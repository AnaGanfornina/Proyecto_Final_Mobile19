//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//

import Fluent
import Vapor

struct ExerciseDTO: Content {
    var id: UUID?
    var name: String
    var description: String
    var repetitions: Int
    var sets: Int
    var trainingID: UUID
    
    func toModel() -> Exercise {
        return Exercise(name: name, description: description, repetitions: repetitions, sets: sets, trainingID: trainingID)
    }
}


extension Exercise {
    func toDTO() -> ExerciseDTO {
        ExerciseDTO(name: self.name, description: self.description, repetitions: self.repetitions, sets: self.sets, trainingID: self.trainingID)
    }
}
