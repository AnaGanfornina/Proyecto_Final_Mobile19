//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 7/9/25.
//

import Vapor
import Fluent

struct UserController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let adminRoutes = routes.grouped(JWTToken.authenticator(), AdminMiddelware(), RateLimitUserMiddleware())
        adminRoutes.get("users", use: getAll) // Solo admin
        
        let userRoutes = routes.grouped("users")
            .grouped(JWTToken.authenticator(), RateLimitUserMiddleware())
        
        userRoutes.group(":userID") { user in
            user.get(use: getByID)
            user.patch(use: update)
            user.delete(use: delete)
        }
    }
}

extension UserController {
    struct CoachWithTraineesDTO: Content {
        let coach: UserDTO
        let trainees: [UserDTO]
    }
}


extension UserController {
    func getAll(_ req: Request) async throws -> [UserDTO] {
        // Obtain JWT token and take coachID
        let token = try req.auth.require(JWTToken.self)
        guard let coachID = UUID(token.userID.value) else {
            throw Abort(.unauthorized, reason: "Error obtaining coachID")
        }
        
        guard let coach = try await User.find(coachID, on: req.db) else {
            throw Abort(.notFound, reason: "Coach not found")
        }
        print("CoachID: \(String(describing: coach.id))")
        
        // Obtain all trainees of the coach
        let trainees = try await User.query(on: req.db)
            .filter(\.$coach.$id == coachID)
            .all()
        
        return trainees.map { $0.toDTO() }
    }
    
    func getByID(_ req: Request) async throws -> UserDTO {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return user.toDTO()
    }
    
    func update(_ req: Request) async throws -> UserDTO {
        
        print("Updating user with ID:", req.parameters.get("userID") ?? "nil")
        
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        let userDTO = try req.content.decode(UserDTO.self)
        
        user.email = userDTO.email
        
     
        user.password = try Bcrypt.hash(userDTO.password)
        
        
        user.role = userDTO.role
        
        if let profile = userDTO.profile {
            
            user.name = profile.name
            
            if let goal = profile.goal {
                user.goal = goal
            }
            if let age = profile.age {
                user.age = age
            }
            if let height = profile.height {
                user.height = height
            }
            if let weight = profile.weight {
                user.weight = weight
            }
            if let coachId = profile.coachID {
                user.$coach.id = coachId
            }
        }
        try await user.update(on: req.db)
        return user.toDTO()
    }
        
    
    func delete(_ req: Request) async throws -> HTTPStatus {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await user.delete(on: req.db)
        
        return .ok
    }
}
