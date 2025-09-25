//
//  User.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

enum Role: String {
    case coach, trainee
    
    init(from role: RoleDTO) {
        switch role {
        case .coach:
            self = .coach
        case .trainee:
            self = .trainee
        }
    }
}

struct User {
    let id: String?
    let email: String
    let password: String
    let role: Role
    let profile: Profile
    
    init(id: String? = nil,
         email: String,
         password: String,
         role: Role,
         profile: Profile) {
        self.id = id
        self.email = email
        self.password = password
        self.role = role
        self.profile = profile
    }
}

struct Profile {
    let name: String
    let goal: String?
    let coachId: String?
    let age: Int?
    let weight: Double?
    let height: Double?
    
    init(name: String,
         goal: String? = nil,
         coachId: String? = nil,
         age: Int? = nil,
         weight: Double? = nil,
         height: Double? = nil) {
        self.name = name
        self.goal = goal
        self.coachId = coachId
        self.age = age
        self.weight = weight
        self.height = height
    }
}
