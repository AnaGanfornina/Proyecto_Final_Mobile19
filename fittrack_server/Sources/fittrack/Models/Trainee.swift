//
//  Trainee.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 13/09/25.
//
import Fluent
import Vapor

final class Trainee: Model, Content, @unchecked Sendable {
    static let schema = "trainees"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Parent(key: "coach_id")
    var coach: User
    
    @Children(for: \.$trainee)
    var goals: [Goal]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(id: UUID,
         name: String,
         coachID: UUID) {
        self.id = id
        self.name = name
        self.$coach.id = coachID
    }
}
