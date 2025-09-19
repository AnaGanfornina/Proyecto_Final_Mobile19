//
//  CreateGoal.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 15/09/25.
//
import Fluent

struct CreateGoal: AsyncMigration {
    
    func prepare(on database: any Database) async throws {
        try await database.schema("goals")
            .id()
            .field("name", .string, .required)
            .field("trainee_id", .uuid, .references("users", "id"))
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("goals")
            .deleteField("trainee_id")
            .delete()
    }
}
