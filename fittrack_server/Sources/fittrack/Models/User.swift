//
//  User.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//
import Fluent
import Vapor

enum UserRole: String, Codable {
    case coach, trainee
}

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
    var role: UserRole
    
    @OptionalParent(key: "coach_id")
    var coach: User?
    
    @Children(for: \.$trainee)
    var goals: [Goal]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(name: String,
         email: String,
         passwordHash: String,
         role: UserRole = .coach,
         coachID: UUID?) {
        self.name = name
        self.email = email
        self.password = passwordHash
        self.role = role
        self.$coach.id = coachID
    }
}

extension User {
    
    func toDTO() -> UserDTO {
        UserDTO(
            id: id,
            name: name,
            email: email,
            passwordHash: password,
            role: role,
            coachID: $coach.id
        )
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
