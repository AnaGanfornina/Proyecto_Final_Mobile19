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
        let adminRoutes = routes.grouped(JWTToken.authenticator(), AdminMiddelware())
        adminRoutes.get("users", use: getAll) // Solo admin
        
        routes.group("users") { users in
            users.group(":userID") { user in
                user.get(use: getByID)
                user.patch(use: update)
                user.delete(use: delete)
            }
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
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        let userDTO = try req.content.decode(UserDTO.self)
        if let name = userDTO.name {
            user.name = name
        }
        
        if let email = userDTO.email {
            user.email = email
        }
        
        if let password = userDTO.password {
            user.password = password
        }
        
        if let role = userDTO.role {
            user.role = role
        }
        
        if let coachId = userDTO.coachID {
            user.$coach.id = coachId
        }
        
        if let goal = user.goal {
            user.goal = goal
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
