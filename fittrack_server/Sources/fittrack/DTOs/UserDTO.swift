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
}

struct UserDTO: Content {
    var id: UUID?
    var name: String?
    var email: String?
    var passwordHash: String?
    var role: UserRole?
    var coachID: UUID?
    
    func toModel(withHashedPassword hashedPassword: String) -> User {
        return User(
            name: name ?? "",
            email: email ?? "",
            passwordHash: hashedPassword,
            role: role ?? .coach,
            coachID: coachID
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
