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
        let tokenProtected = routes.grouped(JWTToken.authenticator(), JWTToken.guardMiddleware())
        
        tokenProtected.group("trainings") { trainings in
        //routes.group("trainings") { trainings in
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
        
        print("Training created \(training)")
        return training.toDTO()
    }
    
    func getAll(_ req: Request) async throws -> [TrainingDTO] {

        // Obtain JWT token and take coachID
        let token = try req.auth.require(JWTToken.self)
        let coachID = UUID(token.userID.value)

        let filter = try? req.query.get(String.self, at: "filter")
        // var query = Training.query(on: req.db)
        
        if filter == "today" {
            // Calcula el rango del día actual
            let startOfToday = Calendar.current.startOfDay(for: Date())
            guard let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday) else {
                throw Abort(.internalServerError, reason: "Error calculating end of day")
            }
            
            // Filter trainees with the coachID
            let trainees = try await User.query(on: req.db)
                .filter(\.$coach.$id == coachID)
                .all()
            print("CoachID from token:", coachID!)
            print("Trainees found for this coach:", trainees.map { ($0.id, $0.name, $0.$coach.id) })
            
            print("Trainees found for coach \(String(describing: coachID)):", trainees.map { $0.id })
            
            let traineeIDs = trainees.compactMap { $0.id }
            
            // Query with joins to filter coach and date
            let trainings = try await Training.query(on: req.db)
                .filter(\.$trainee.$id ~~ traineeIDs) // Filtrar por traineesIds
                .filter(\.$scheduledAt >= startOfToday)
                .filter(\.$scheduledAt < endOfDay)
                .sort(\.$scheduledAt, .ascending)
                .all()
            
            return trainings.map { $0.toDTO()}
        } else {
            // Obtain all trainees of the coach
            let trainees = try await User.query(on: req.db)
                .filter(\.$coach.$id == coachID)
                .all()

            let traineeIDs = trainees.compactMap { $0.id }
          
            
            // Obtain all trainings from trainees
            let trainings = try await Training.query(on: req.db)
                .filter(\.$trainee.$id ~~ traineeIDs)
                .all()
            
            print("Trainings found:", trainings.map { $0.id })
            
            return trainings.map {$0.toDTO()}
        }
    }
        
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
           
            training.name = trainingDTO.name
            training.$trainee.id = trainingDTO.traineeID
            training.scheduledAt = trainingDTO.scheduledAt
            
            
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
    

