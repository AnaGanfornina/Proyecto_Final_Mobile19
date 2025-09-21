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
    let coachID: UUID?
    
    enum CodingKeys: String, CodingKey {
        case name, email, password, role
        case coachID = "coach_id"
    }
    
    func toModel(withHashedPassword password: String) -> User {
        User(
            name: name,
            email: email,
            passwordHash: password,
            role: role,
            coachId: coachID
            )
    }
}

struct UserDTO: Content {
    var id: UUID?
    var name: String?
    var email: String?
    var password: String?
    var role: UserRole?
    var coachId: UUID?
    
    func toModel(withHashedPassword password: String) -> User {
        return User(
            name: name ?? "",
            email: email ?? "",
            passwordHash: password,
            role: role ?? .coach,
            coachId: coachId
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
