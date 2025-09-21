//
//  CreateTraining.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 15/09/25.
//
import Fluent

struct CreateTraining: AsyncMigration {
    
    func prepare(on database: any Database) async throws {
        try await database.schema("trainings")
            .id()
            .field("name", .string, .required)
            .field("trainee_id", .uuid, .references("users", "id"))
            .field("scheduled_at", .datetime, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("trainings")
            .deleteField("trainee_id")
            .delete()
    }
}


