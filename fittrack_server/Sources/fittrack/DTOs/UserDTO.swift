//
//  UserDTO.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//
import Fluent
import Vapor


struct UserRegisterDTO: Content {
    let name: String
    let email: String
    let password: String
    let role: UserRole
    var coachID: UUID?
    let goal: String?
    let age: Int?
    let height: Int?
    let weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, email, password, role, goal, age, height, weight
        case coachID = "coach_id"
    }
    
    func toModel(withHashedPassword password: String) -> User {
        User(
            name: name,
            email: email,
            passwordHash: password,
            role: role,
            coachId: coachID,
            goal: goal,
            age: age,
            height: height,
            weight: weight
            )
    }
}

struct UserDTO: Content {
    var id: UUID?
    var name: String?
    var email: String?
    var password: String?
    var role: UserRole?
    var coachID: UUID?
    var goal: String?
    let age: Int?
    let height: Int?
    let weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, password, role, goal, age, height, weight
        case coachID = "coach_id"
    }
    
    func toModel(withHashedPassword password: String) -> User {
        return User(
            name: name ?? "",
            email: email ?? "",
            passwordHash: password,
            role: role ?? .coach,
            coachId: coachID,
            goal: goal,
            age: age,
            height: height,
            weight: weight
        )
    }
}


extension UserRegisterDTO: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: .count(2...50), required: true)
        validations.add("email", as: String.self, is: .count(5...25) && .email, required: true)
        validations.add("password", as: String.self, is: .count(6...15) && .alphanumeric, required: true)
    }
}
