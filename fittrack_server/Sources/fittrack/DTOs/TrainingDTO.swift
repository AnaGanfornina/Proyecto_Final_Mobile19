//
//  TrainingDTO.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 14/09/25.
//
import Fluent
import Vapor

struct TrainingDTO: Content {
    let id: UUID?
    let name: String
    let traineeID: UUID
    let scheduledAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, scheduledAt
        case traineeID = "trainee_id"
    }
    
    func toModel() -> Training {
        .init(
            id: id ?? UUID(),
            name: name,
            traineeID: traineeID,
            scheduledAt: scheduledAt
        )
    }
}

extension Training {
    func toDTO() -> TrainingDTO {
        .init(
            id: id ?? UUID(),
            name: name,
            traineeID: $trainee.id,
            scheduledAt: scheduledAt
        )
    }
}
