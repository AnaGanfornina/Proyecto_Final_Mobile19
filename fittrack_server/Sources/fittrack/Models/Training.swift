//
//  Training.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 14/09/25.
//

import Fluent
import Vapor

final class Training: Model, Content, @unchecked Sendable {
    static let schema = "trainings"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Parent(key: "goal_id")
    var goal: Goal
    
    @Field(key: "scheduled_at")
    var scheduledAt: Date
    
    @Timestamp(key: "created_at", on: .create)
    var created_at: Date?
    
    @Timestamp(key: "updated_at", on: .create)
    var updated_at: Date?
    
    init() {}
    
    init(id: UUID,
         name: String,
         goalId: UUID,
         scheduledAt:Date
    ) {
        self.id = id
        self.name = name
        self.$goal.id = goalId
        self.scheduledAt = scheduledAt
    }
}
