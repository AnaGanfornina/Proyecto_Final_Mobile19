//
//  User.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

enum Role {
    case coach, trainee
}

struct User {
    let id: String?
    let email: String
    let password: String
    let role: Role
    let profile: Profile
}

struct Profile {
    let name: String
    let coachId: String?
    let age: Int?
    let weight: Double?
    let height: Double?
}
