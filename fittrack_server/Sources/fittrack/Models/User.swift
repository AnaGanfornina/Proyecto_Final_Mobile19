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
    
    @Field(key: "goal")
    var goal: String?
    
    @Field(key: "age")
    var age: Int?
    
    @Field(key: "height")
    var height: Int?
    
    @Field(key: "weight")
    var weight: Int?
    
    @OptionalParent(key: "coach_id")
    var coach: User?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(name: String,
         email: String,
         passwordHash: String,
         role: UserRole = .coach,
         coachId: UUID?,
         goal: String? = nil,
         age: Int? = nil,
         height: Int? = nil,
         weight: Int? = nil
    ) {
        self.name = name
        self.email = email
        self.password = passwordHash
        self.role = role
        self.$coach.id = coachId
        self.goal = goal
        self.age = age
        self.height = height
        self.weight = weight
    }
}

extension User {
    
    func toDTO() -> UserDTO {
        UserDTO(
            id: id,
            name: name,
            email: email,
            password: password,
            role: role,
            coachID: $coach.id,
            goal: goal,
            age: age,
            height: height,
            weight: weight
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
