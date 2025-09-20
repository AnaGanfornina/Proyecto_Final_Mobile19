//
//  TrainingController.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 15/09/25.
//
import Vapor
import Fluent

struct TrainingController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.group("trainings") { trainings in
            trainings.post(use: create)
            trainings.get(use: getAll)
            trainings.group(":trainingID") { training in
                training.get(use: getByID)
                training.patch(use: update)
                training.delete(use: delete)
            }
        }
    }
}

extension TrainingController {
    func create(_ req: Request) async throws -> TrainingDTO {
        let trainingDTO = try req.content.decode(TrainingDTO.self)
        let training = trainingDTO.toModel()
        try await training.create(on: req.db)
        
        return training.toDTO()
    }
    
    func getAll(_ req: Request) async throws -> [TrainingDTO] {
        let filter = try? req.query.get(String.self, at: "filter")
        
        var query = Training.query(on: req.db)
        
        if filter == "today" {
            let startOfDay = Calendar.current.startOfDay(for: Date())
            let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)
            
            query = query
                .filter(\.$created_at >= startOfDay)
                .filter(\.$created_at < endOfDay)
        }
        return try await query.all().map { $0.toDTO() }
    }
    
//    func getToday(_ req: Request) async throws -> [TrainingDTO] {
//        // Validate token
//        let token = try req.auth.require(JWTToken.self)
//        let coachID = UUID(token.userID.value)
//        
//        // Calculate range of dates for the actual day
//        let startOfDay = Calendar.current.startOfDay(for: Date())
//        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // Query (avoiding N+1)
        //        let trainings = try await Training.query(on: req.db)
        //            .join(parent: \Training.$goal)
        //            .join(parent: \Goal.$trainee)
        //            .filter(User.self, \.$coach.$id == coachID)
        //            .filter(\.$scheduledAt >= startOfDay)
        //            .filter(\.$scheduledAt < endOfDay)
        //            .sort(\.$scheduled_at, .as)
        //            .with(\.$goal) { goal in
        //                goal.with(\.$trainee)
        //            }
        //            .all()
        //
        //        return trainings.map { $0.toDTO()}
        //    }
        
        func getByID(_ req: Request) async throws -> TrainingDTO {
            guard let training = try await Training.find(req.parameters.get("trainingID"), on: req.db) else {
                throw Abort(.notFound)
            }
            
            return training.toDTO()
        }
        
        func update(_ req: Request) async throws -> TrainingDTO {
            guard let training = try await Training.find(req.parameters.get("trainingID"), on: req.db) else {
                throw Abort(.notFound)
            }
            
            let trainingDTO = try req.content.decode(TrainingDTO.self)
            training.$goal.id = trainingDTO.goalId
            
            try await training.update(on: req.db)
            
            return training.toDTO()
        }
        
        func delete(_ req: Request) async throws -> HTTPStatus {
            guard let training = try await Training.find(req.parameters.get("trainingID"), on: req.db) else {
                throw Abort(.notFound)
            }
            
            try await training.delete(on: req.db)
            
            return .ok
        }
    }
    

