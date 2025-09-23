//
//  SignupDTO.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

enum RoleDTO: Encodable {
    case coach, trainee
    
    init(from role: Role) {
        switch role {
        case .coach:
            self = .coach
        case .trainee:
            self = .trainee
        }
    }
}

struct UserDTO: Encodable {
    let id: String?
    let email: String
    let password: String
    let role: RoleDTO
    let profile: ProfileDTO
    
    enum CodingKeys: String, CodingKey {
        case id, email, password, role, profile
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(role, forKey: .role)
        try container.encode(profile, forKey: .profile)
    }
}

struct ProfileDTO: Encodable {
    let name: String
    let goal: String?
    let coachId: String?
    let age: Int?
    let weight: Double?
    let height: Double?
    
    enum CodingKeys: String, CodingKey {
        case name, goal
        case coachId = "coach_id"
        case age, weight, height
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(goal, forKey: .name)
        try container.encodeIfPresent(coachId, forKey: .coachId)
        try container.encodeIfPresent(age, forKey: .age)
        try container.encodeIfPresent(weight, forKey: .weight)
        try container.encodeIfPresent(height, forKey: .height)
    }
}
