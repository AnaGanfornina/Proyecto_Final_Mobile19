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
        routes.group("users") { users in
            users.get(use: getAll)
            users.group(":userID") { user in
                user.get(use: getByID)
                user.patch(use: update)
                user.delete(use: delete)
            }
        }
    }
}


extension UserController {
    func getAll(_ req: Request) async throws -> [UserDTO] {
        try await User.query(on: req.db).all().map { $0.toDTO() }
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
        
        if let password = userDTO.passwordHash {
            user.password = password
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
