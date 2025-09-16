//
//  GoalController.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 14/09/25.
//
import Vapor
import Fluent

struct GoalController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.group("goals") { goals in
            goals.post(use: create)
            goals.get(use: getAll)
            goals.group(":goalID") { goal in
                goal.get(use: getByID)
                goal.patch(use: update)
                goal.delete(use: delete)
            }
        }
    }
}

extension GoalController {
    func create(_ req: Request) async throws -> GoalDTO {
        let goalDTO = try req.content.decode(GoalDTO.self)
        let goal = goalDTO.toModel()
        try await goal.create(on: req.db)
        
        return goal.toDTO()
    }
    
    func getAll(_ req: Request) async throws -> [GoalDTO] {
        try await Goal.query(on: req.db).all().map { $0.toDTO() }
    }
    
    func getByID(_ req: Request) async throws -> GoalDTO {
        guard let goal = try await Goal.find(req.parameters.get("goalID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        return goal.toDTO()
    }
    
    func update(_ req: Request) async throws -> GoalDTO {
        guard let goal = try await Goal.find(req.parameters.get("goalID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        let goalDTO = try req.content.decode(GoalDTO.self)
        if let name = goalDTO.name {
            goal.name = name
        }
        
        if let traineeID = goalDTO.traineeId {
            goal.$trainee.id = traineeID
        }
        
        try await goal.update(on: req.db)
        
        return goal.toDTO()
    }
    
    func delete(_ req: Request) async throws -> HTTPStatus {
        guard let goal = try await Goal.find(req.parameters.get("goalID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await goal.delete(on: req.db)
        
        return .ok
    }
}
