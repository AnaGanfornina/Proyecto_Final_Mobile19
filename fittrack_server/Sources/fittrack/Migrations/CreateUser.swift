//
//  CreateUser.swift
//  fittrack_server
//
//  Created by Ariana Rodríguez on 13/09/25.
//
import Fluent

struct CreateUser: AsyncMigration {
    
    func prepare(on database: any Database) async throws {
        try await database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("password", .string, .required)
            .field("role", .string, .required)
            .field("coach_id", .uuid, .references("users", "id"))
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("users")
            .deleteField("coach_id")
            .delete()
    }
}
