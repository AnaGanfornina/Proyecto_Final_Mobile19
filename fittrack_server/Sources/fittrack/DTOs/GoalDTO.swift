//
//  GoalDTO.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 14/09/25.
//
import Fluent
import Vapor

struct GoalDTO: Content {
    let id: UUID?
    let name: String?
    let traineeId: UUID?
    
    func toModel() -> Goal {
        .init(id: id ?? UUID(),
              name: name ?? "",
              traineeID: traineeId ?? UUID()
        )
    }
}

extension Goal {
    func toDTO() -> GoalDTO {
        .init(id: id,
              name: name,
              traineeId: $trainee.id
        )
    }
}


