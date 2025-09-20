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
    let goalId: UUID
    let scheduledAt: Date
    
    func toModel() -> Training {
        .init(
            id: id ?? UUID(),
            name: name,
            goalId: goalId,
            scheduledAt: scheduledAt
        )
    }
}

extension Training {
    func toDTO() -> TrainingDTO {
        .init(
            id: id ?? UUID(),
            name: name,
            goalId: $goal.id,
            scheduledAt: scheduledAt
        )
    }
}
