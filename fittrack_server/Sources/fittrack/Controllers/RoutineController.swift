//
//  RoutineController.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 15/09/25.
//
import Vapor
import Fluent

struct RoutineController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.group("routines") { routines in
            routines.post(use: create)
            routines.get(use: getAll)
            routines.group(":routineID") { routine in
                routine.get(use: getByID)
                routine.patch(use: update)
                routine.delete(use: delete)
            }
        }
    }
}

extension RoutineController {
    func create(_ req: Request) async throws -> RoutineDTO {
        let routineDTO = try req.content.decode(RoutineDTO.self)
        let routine = routineDTO.toModel()
        try await routine.create(on: req.db)
        
        return routine.toDTO()
    }
    
    func getAll(_ req: Request) async throws -> [RoutineDTO] {
        try await Routine.query(on: req.db).all().map { $0.toDTO() }
    }
    
    func getByID(_ req: Request) async throws -> RoutineDTO {
        guard let routine = try await Routine.find(req.parameters.get("routineID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        return routine.toDTO()
    }
    
    func update(_ req: Request) async throws -> RoutineDTO {
        guard let routine = try await Routine.find(req.parameters.get("routineID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        let routineDTO = try req.content.decode(RoutineDTO.self)
        routine.$goal.id = routineDTO.goalId
        
        try await routine.update(on: req.db)
        
        return routine.toDTO()
    }
    
    func delete(_ req: Request) async throws -> HTTPStatus {
        guard let routine = try await Routine.find(req.parameters.get("routineID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await routine.delete(on: req.db)
        
        return .ok
    }
}
