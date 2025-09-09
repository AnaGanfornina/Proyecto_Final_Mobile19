//
//  User.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//
import Fluent
import Vapor


final class User: Model, Content, @unchecked Sendable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "role")
    var isAdmin: Bool
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    // Relaciones futuras (appointments, trainings, exercises)
    // @Children(for: \.$user) var trainings: [Training]
    // @Children(for: \.$user) var appointments: [Appointment]
    
    init() {}
    
    init(name: String, email: String, passwordHash: String, isAdmin: Bool = false ) {
        self.name = name
        self.email = email
        self.password = password
    }
}

extension User {
    
    func toDTO() -> UserDTO {
        UserDTO(id: self.id, name: self.name, email: self.email, passwordHash: self.password, isAdmin: self.isAdmin)
    }
}

extension User: ModelAuthenticatable {
    static var usernameKey: KeyPath<User, Field<String>> {
        \User.$email
    }
    static var passwordHashKey: KeyPath<User, Field<String>> {
        \User.$password
    }
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}
