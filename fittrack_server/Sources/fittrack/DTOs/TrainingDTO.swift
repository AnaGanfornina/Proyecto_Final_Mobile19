//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//

import Fluent
import Vapor

struct TrainingDTO: Content {
    var id: UUID?
    var name: String
    var start: Date
    var end: Date
    var userID: UUID
    
    func toModel() -> Training {
        return Training(name: name, start: start, end: end, userID: userID)
    }
}

extension Training {
    func toDTO() -> TrainingDTO {
        TrainingDTO(name: self.name, start: self.start, end: self.end, userID: self.userID)
    }
}
