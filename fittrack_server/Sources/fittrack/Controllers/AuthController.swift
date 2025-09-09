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
        
        routes.group("auth") { builder in
            
            builder.post("register", use: register)
            
            builder.group(User.authenticator(), User.guardMiddleware()) { builder in
                builder.post("login", use: login)
            }
            
            builder.group(JWTToken.authenticator(), JWTToken.guardMiddleware()) { builder in
                builder.post("refresh", use: refresh)
                
            }
        }
    }
}


extension AuthController {
    func register(req: Request)async throws -> JWTTokenDTO {
        
        //validate data
        try UserDTO.validate(content: req)
        
        // decode data and hash pass
        let create = try req.content.decode(UserDTO.self)
        let hashedPassword = try await req.password.async.hash(create.passwordHash)
        
        // save to user DB
        let user = create.toModel(withHashedPassword: hashedPassword)
        try await user.create(on: req.db)
        
        // create JWT
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
}
