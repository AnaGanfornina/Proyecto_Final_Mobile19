//
//  UserDTO.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//
import Fluent
import Vapor


struct UserRegisterDTO: Content {
    
    let email: String
    let password: String
    let role: UserRole
    var profile: ProfileDTO?
    
    
    enum CodingKeys: String, CodingKey {
        case email, password, role, profile
    }
    
    func toModel(withHashedPassword password: String) -> User {
        guard let profile = profile else {
            fatalError("Profile data is required to create User")
        }
        return User(
            name: profile.name,
            email: email,
            passwordHash: password,
            role: role,
            coachId: profile.coachID,
            goal: profile.goal,
            age: profile.age,
            height: profile.height,
            weight: profile.weight
        )
    }
}

struct ProfileDTO: Content {
    let name: String
    var coachID: UUID?
    let goal: String?
    let age: Int?
    let height: Double?
    let weight: Double?
    
    enum CodingKeys: String, CodingKey {
        case name, goal, age, height, weight
        case coachID = "coach_id"
    }
}


struct UserDTO: Content {
    var id: UUID?
    var email: String
    var password: String
    var role: UserRole
    var profile: ProfileDTO?
    
    enum CodingKeys: String, CodingKey {
        case id, email, password, role, profile
    }
    
    func toModel(withHashedPassword password: String) -> User {
        guard let profile = profile else {
            fatalError("Profile data is required to create User")
        }
        return User(
            name: profile.name,
            email: email,
            passwordHash: password,
            role: role,
            coachId: profile.coachID,
            goal: profile.goal,
            age: profile.age,
            height: profile.height,
            weight: profile.weight
        )
    }
}

extension UserRegisterDTO: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .count(5...25) && .email, required: true)
        validations.add("password", as: String.self, is: .count(6...15) && .alphanumeric, required: true)
    }
}

extension ProfileDTO: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: .count(2...50), required: true)
    }
}

