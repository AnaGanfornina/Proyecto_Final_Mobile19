//
//  UserDTO.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//
import Fluent
import Vapor

struct UserDTO: Content {
    
    var id: UUID?
    var name: String
    var email: String
    var passwordHash: String
    var role: UserRole
    
    func toModel() -> User {
        return User(name: name, email: email, passwordHash: passwordHash, role: role)
    }
}

extension User {
    
    func toDTO() -> UserDTO {
        UserDTO(id: self.id, name: self.name, email: self.email, passwordHash: self.passwordHash, role: self.role)
    }
}

extension UserDTO: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: .count(2...50), required: true)
    }
}
