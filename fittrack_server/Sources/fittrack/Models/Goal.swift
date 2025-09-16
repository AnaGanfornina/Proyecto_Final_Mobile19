//
//  Goal.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 13/09/25.
//
import Fluent
import Vapor

final class Goal: Model, Content, @unchecked Sendable {
    static let schema = "goals"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Parent(key: "trainee_id")
    var trainee: User
    
    @Children(for: \.$goal)
    var trainings: [Training]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .create)
    var updatedAt: Date?
    
    init() {}
    
    init(id: UUID,
         name: String,
         traineeID: UUID) {
        self.id = id
        self.name = name
        self.$trainee.id = traineeID
    }
}
