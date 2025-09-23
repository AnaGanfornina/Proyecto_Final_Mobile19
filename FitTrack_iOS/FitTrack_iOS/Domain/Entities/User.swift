//
//  User.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

enum UserRole {
    case coach, trainee
}

struct User {
    let name: String
    let email: String
    let password: String
    let role: UserRole
    let metrics: UserMetrics?
}

struct UserMetrics {
    let coachId: String
    let age: Int
    let weight: Double
    let height: Double
}
