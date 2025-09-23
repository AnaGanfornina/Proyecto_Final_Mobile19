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
        name: "Álvaro Entrena",
        email: "alvaro@gmail.com",
        password: "abcd1234",
        role: .coach,
        metrics: nil
    )
    
    static let givenUserDTO = UserDTO(
        name: "Álvaro Entrena",
        email: "alvaro@gmail.com",
        password: "abcd1234",
        role: UserRoleDTO(from: .coach),
        metrics: nil
    )
}
