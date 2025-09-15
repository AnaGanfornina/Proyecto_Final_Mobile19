//
//  CreateRoutine.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 15/09/25.
//
import Fluent

struct CreateRoutine: AsyncMigration {
    
    func prepare(on database: any Database) async throws {
        try await database.schema("routines")
            .id()
            .field("name", .string, .required)
            .field("goal_id", .uuid, .references("goals", "id"))
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("routines")
            .deleteField("goal_id")
            .delete()
    }
}
