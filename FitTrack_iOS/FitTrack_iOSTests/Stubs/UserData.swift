//
//  UserData.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation
@testable import FitTrack_iOS

enum UserData {
    static let givenUser = User(
        id: nil,
        email: "alvaro@gmail.com",
        password: "abcd1234",
        role: .coach,
        profile: Profile(
            name: "Alvaro Entrena",
            coachId: nil,
            age: nil,
            weight: nil,
            height: nil
        )
    )
    
    static let givenUserWithWrongEmail = User(
        id: nil,
        email: "nagumo",
        password: "abcd1234",
        role: .trainee,
        profile: Profile (
            name: "Ariana Nagumo",
            coachId: nil,
            age: nil,
            weight: nil,
            height: nil
        )
    )
    
    static let givenUserDTO = UserDTO(
        id: nil,
        email: "alvaro@gmail.com",
        password: "abcd1234",
        role: RoleDTO(from: .coach),
        profile: ProfileDTO(
            name: "Alvaro Entrena",
            coachId: nil,
            age: nil,
            weight: nil,
            height: nil
        )
    )
}
