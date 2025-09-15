//
//  RoutineDTO.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 14/09/25.
//
import Fluent
import Vapor

struct RoutineDTO: Content {
    let id: UUID?
    let name: String
    let goalId: UUID
    
    func toModel() -> Routine {
        .init(
            id: id ?? UUID(),
            name: name,
            goalId: goalId
        )
    }
}

extension Routine {
    func toDTO() -> RoutineDTO {
        .init(
            id: id ?? UUID(),
            name: name,
            goalId: $goal.id
        )
    }
}
