//
//  User.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//
import Fluent
import Vapor

enum UserRole: String, Codable {
    case user
    case admin
}

final class User: Model, Content, @unchecked Sendable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Enum(key: "role")
    var role: UserRole
    
    // Relaciones futuras (appointments, trainings, exercises)
    // @Children(for: \.$user) var trainings: [Training]
    // @Children(for: \.$user) var appointments: [Appointment]
    
    init() {}
    
    init(name: String, email: String, passwordHash: String, role: UserRole) {
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.role = role 
    }
}
