//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//

import Fluent
import Vapor

struct AppointmentDTO: Content {
    var id: UUID?
    var date: Date
    var trainer: String
    var userID: UUID
    
    func toModel() -> Appointment {
        return Appointment(date: date, trainer: trainer, userID: userID)
    }
}

extension Appointment {
    func toDTO() -> AppointmentDTO {
        AppointmentDTO(date: self.date, trainer: self.trainer, userID: self.userID)
    }
}
