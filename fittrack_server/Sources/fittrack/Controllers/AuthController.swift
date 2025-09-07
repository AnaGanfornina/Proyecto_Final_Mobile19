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
        }
    }
}


extension AuthController {
    func register(req: Request)async throws -> HTTPStatus {
        
        //validate data
        try UserDTO.validate(content: req)
        
        // decode data and hash pass
        let create = try req.content.decode(UserDTO.self)
        let hashedPassword = try await req.password.async.hash(create.passwordHash)
        
        // save to user DB
        let user = create.toModel(withHashedPassword: hashedPassword)
        try await user.create(on: req.db)
        
        // create JWT
        
    }
    
    func login(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        
        // Create JWT
        
        return .ok
    }
    
    func refresh(req: Request) async throws -> HTTPStatus {
        .ok
    }
}
