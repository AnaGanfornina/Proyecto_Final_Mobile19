//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 7/9/25.
//

import Fluent
import Vapor

struct AuthController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.group("auth") { auth in
            
            auth.group("register") { register in
                register.post("coach", use: registerCoach)
                
                register.group(JWTToken.authenticator(),JWTToken.guardMiddleware()) { secure in
                    secure.post("trainee", use: registerTrainee)
            }
        }
    
            auth.group(User.authenticator(), User.guardMiddleware()) { builder in
                builder.post("login", use: login)
            }
            auth.group(JWTToken.authenticator(), JWTToken.guardMiddleware()) { builder in
                builder.post("refresh", use: refresh)
                
            }
        }
    }
}



extension AuthController {
    func registerCoach(req: Request) async throws -> JWTTokenDTO {
        
        // Validate and decode
        try UserRegisterDTO.validate(content: req)
        
        let registerDTO = try req.content.decode(UserRegisterDTO.self)
        
        if try await User.query(on: req.db)
            .filter(\.$email == registerDTO.email)
            .first() != nil {
            throw Abort(.conflict, reason: "Email already registered")
        }
        
        // If coach, no token
        let hashedPassword = try await req.password.async.hash(registerDTO.password)
        let user = registerDTO.toModel(withHashedPassword: hashedPassword)
        try await user.create(on: req.db)
        
        return try await generateJWTTokens(
            for: user.email,
            and: user.requireID(),
            withRequest: req
        )
    }
    
    func registerTrainee(req: Request) async throws -> JWTTokenDTO {
        // Validate and decode
        try UserRegisterDTO.validate(content: req)
        let registerDTO = try req.content.decode(UserRegisterDTO.self)
        
        if try await User.query(on: req.db)
            .filter(\.$email == registerDTO.email)
            .first() != nil {
            throw Abort(.conflict, reason: "Email already registered")
        }
        
        // Request with token
        let token = try req.auth.require(JWTToken.self)
        
        guard let coachID = UUID(token.userID.value) else {
            throw Abort(.unauthorized, reason: "Invalid coach token")
        }
        
        // Verify if coach exists
        guard let coach = try await User.find(coachID, on: req.db), coach.role == .coach else {
            throw Abort(.badRequest, reason: "Coach not found or invalid")
        }
        
        // Overwrite coachID on DTO
        var traineeDTO = registerDTO
        traineeDTO.profile?.coachID = coachID
        
        // Create user with traineeDTO
        let hashedPassword = try await req.password.async.hash(traineeDTO.password)
        let user = traineeDTO.toModel(withHashedPassword: hashedPassword)
        try await user.create(on: req.db)
        
        return try await generateJWTTokens(
            for: user.email,
            and: user.requireID(),
            withRequest: req
        )
    }
    
    
    func login(req: Request) async throws -> JWTTokenDTO {
        
        let user = try req.auth.require(User.self)
        
        // Create JWT
        
        return try await generateJWTTokens(
            for: user.email,
            and: user.requireID(),
            withRequest: req
        )
    }
}

func refresh(req: Request) async throws -> JWTTokenDTO {
    let token = try req.auth.require(JWTToken.self)
    
    guard token.isRefresh.value else {
        throw Abort(.unauthorized)
    }
    
    guard let uuid = UUID(token.userID.value) else {
        throw Abort(.unauthorized)
    }
    
    return try await generateJWTTokens(
        for: token.userName.value,
        and: uuid,
        withRequest: req
    )
}

private func generateJWTTokens(
    for username: String,
    and userID: UUID,
    withRequest req: Request
) async throws -> JWTTokenDTO {
    let tokens = JWTToken.generateTokens(for: username, andID: userID)
    async let accessToken = req.jwt.sign(tokens.accessToken)
    async let refreshToken = req.jwt.sign(tokens.refreshToken)
    return try await JWTTokenDTO(accessToken: accessToken, refreshToken: refreshToken)
}


