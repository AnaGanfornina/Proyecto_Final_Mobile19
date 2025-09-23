//
//  SignupDTO.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

enum UserRoleDTO: Encodable {
    case coach, trainee
    
    init(from userRole: UserRole) {
        switch userRole {
        case .coach:
            self = .coach
        case .trainee:
            self = .trainee
        }
    }
}

struct UserDTO: Encodable {
    let name: String
    let email: String
    let password: String
    let role: UserRoleDTO
    let metrics: UserMetricsDTO?
}

struct UserMetricsDTO: Encodable {
    let coachId: String
    let age: Int
    let weight: Double
    let height: Double
    
    enum CodingKeys: String, CodingKey {
        case coachId = "coach_id"
        case age, weight, height
    }
}
