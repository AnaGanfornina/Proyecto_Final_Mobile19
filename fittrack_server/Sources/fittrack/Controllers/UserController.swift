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
            
            builder.post(use: create)
            builder.post("login", use: login)
            
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
    
    func create(_ req: Request) async throws -> UserDTO {
        
        // Validations
        try UserDTO.validate(content: req)
        
        // Decoding
        let create = try req.content.decode(UserDTO.self)
        
        // Model
        let model = create.toModel()
        
        //Save to DB
        try await model.save(on: req.db)
        
        return model.toDTO()
    }
    
    func login(_ req: Request) async throws -> String {
        let loginData = try req.content.decode(UserLoginDTO.self)
        guard let user = try await User.query(on: req.db)
            .filter(\.$email == loginData.email)
            .first() else {
            throw Abort(.unauthorized)
        }
        guard try 
    }
    
    func update(_ req: Request) async throws -> UserDTO {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let dto = try req.content.decode(UserDTO.self)
        user.name = dto.name
        user.email = dto.email
        user.passwordHash = dto.passwordHash
        user.role = dto.role
        
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
