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
        routes.group("users") { builder in
            builder.get(use: index)
            builder.get(":userID",use: getByID)
            
            builder.put(use: update)
            
            builder.delete(":userID", use: delete)
        }
    }
}


extension UserController {
    func index(_ req: Request) async throws -> [UserDTO] {
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
        let dto = try req.content.decode(UserDTO.self)
        user.name = dto.name
        user.email = dto.email
        user.password = dto.passwordHash
        user.isAdmin = dto.isAdmin
        
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
