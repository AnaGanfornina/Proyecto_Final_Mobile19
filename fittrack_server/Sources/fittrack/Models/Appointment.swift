//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//

import Foundation
import Vapor
import Fluent

final class Appointment: Model, Content, @unchecked Sendable {
    static let schema = "appointment"
    
    @ID(key: .id)
    var id: UUID?
    
    @Timestamp(key: "date", on: .create)
    var date: Date?
    
    @Field(key: "trainer")
    var trainer: String
    
    @Field(key: "userID")
    var userID: UUID
    
    init() {}
    
    init(date: Date, trainer: String, userID: UUID) {
        self.date = date
        self.trainer = trainer
        self.userID = userID
    }
}


// TODO: OJO, el force unwrap hay que quitarlo!!!

extension Appointment {
    func toDTO() -> AppointmentDTO {
        AppointmentDTO(date: self.date!, trainer: self.trainer, userID: self.userID)
    }
}
