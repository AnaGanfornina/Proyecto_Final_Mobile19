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
            trainings.post(use: create)
            trainings.get(use: getAll)
            trainings.get("byMonth",use: getByMonth)
                                           
        tokenProtected.group("training") { training in
            training.group(":trainingID") { training in
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
        
        
        // TODO: ELIMINAR PRINT
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
            
            // TODO: ELIMINAR PRINTS
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
    
    func getByMonth(_ req: Request) async throws -> [TrainingDTO] {
        // Returns all trainings for the coach's trainees for a given month and year.
        let token = try req.auth.require(JWTToken.self)
        let coachID = UUID(token.userID.value)
        
        // Read month and year query parameters
        guard let month = try? req.query.get(Int.self, at: "month"),
              let year = try? req.query.get(Int.self, at: "year"),
              (1...12).contains(month) else {
            throw Abort(.badRequest, reason: "Mission or invalid 'month' (1-12) or 'year' parameter")
        }
        
        // Calculate start and end date of the month
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        var startComponents = DateComponents()
        startComponents.year = year
        startComponents.month = month
        startComponents.day = 1
        guard let startOfMonth = calendar.date(from: startComponents) else {
            throw Abort(.internalServerError, reason: "Could not calculate start of month")
        }
        var endComponents = DateComponents()
        endComponents.year = year
        endComponents.month = month + 1
        endComponents.day = 1
        // If December, next month is January of next year
        if month == 12 {
            endComponents.year = year + 1
            endComponents.month = 1
        }
        
        guard let endOfMonth = calendar.date(from: endComponents) else {
            throw Abort(.internalServerError, reason: "Couldn't calculate end of month")
        }
        
        // Obtain all trainees whose coachID matches coachID
        let trainees = try await User.query(on: req.db)
            .filter(\.$coach.$id == coachID)
            .all()
        
        let traineeIDs = trainees.compactMap { $0.id }
        
        if traineeIDs.isEmpty {
            return []
        }
        
        print("StartOfMonth:", startOfMonth)
        print("EndOfMonth:", endOfMonth)
        
        // Filter trainings by scheduledAt within the month for those trainees
        let trainings = try await Training.query(on: req.db)
            .filter(\.$trainee.$id ~~ traineeIDs)
            .filter(\.$scheduledAt >= startOfMonth)
            .filter(\.$scheduledAt < endOfMonth)
            .sort(\.$scheduledAt, .ascending)
            .all()
        
        return trainings.map { $0.toDTO() }
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


