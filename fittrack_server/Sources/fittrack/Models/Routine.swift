//
//  Routine.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 14/09/25.
//

import Fluent
import Vapor

final class Routine: Model, Content, @unchecked Sendable {
    static let schema = "routines"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Parent(key: "goal_id")
    var goal: Goal
    
    @Timestamp(key: "created_at", on: .create)
    var created_at: Date?
    
    @Timestamp(key: "updated_at", on: .create)
    var updated_at: Date?
    
    init() {}
    
    init(id: UUID,
         name: String,
         goalId: UUID) {
        self.id = id
        self.name = name
        self.$goal.id = goalId
    }
}
