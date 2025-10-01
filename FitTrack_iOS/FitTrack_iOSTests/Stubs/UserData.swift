//
//  UserData.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation
@testable import FitTrack_iOS

enum UserData {
    static let givenAuthDTO = AuthDTO(
        accessToken: "accessToken",
        refreshToken: "refreshToken"
    )
    
    static let givenUser = User(
        email: "alvaro@gmail.com",
        password: "abcd1234",
        role: .coach,
        profile: Profile(
            name: "Alvaro"
        )
    )
    
    static let givenTraineeUser = User(
        email: "ari@gmail.com",
        password: "abcd1234",
        role: .trainee,
        profile: Profile(
            name: "Ari",
            goal: "Maratón de Madrid",
            weight: 54,
            height: 1.70
        )
    )
    
    static let givenUserWithWrongEmail = User(
        email: "nagumo",
        password: "abcd1234",
        role: .trainee,
        profile: Profile (
            name: "Ariana",
            goal: "Maratón de la Ciudad de México"
        )
    )
    
    static let givenUserDTO = UserDTO(
        email: "alvaro@gmail.com",
        password: "abcd1234",
        role: RoleDTO(from: .coach),
        profile: ProfileDTO(
            name: "Alvaro",
            goal: "Maratón de Madrid"
        )
    )
    
    static let givenUsers = [
        User(
            id: "5FFF81DE-C845-49B0-8BA0-C6AE19EC9A85",
            email: "nagumo@keepcoding.es",
            password: "abcd1234",
            role: .trainee,
            profile: Profile (
                name: "Ari",
                goal: "Maratón de la Ciudad de México",
                age: 28,
                weight: 60,
                height: 1.54
            )),
        User(
            id: "5FFF81DE-C845-49B0-8BA0-C6AE19EC9A85",
            email: "ana@keepcoding.es",
            password: "abcd1234",
            role: .trainee,
            profile: Profile (
                name: "Ana",
                goal: "Maratón de la Ciudad de México",
                age: 28,
                weight: 60,
                height: 1.54
            )),
        User(
            id: "0B75E4C6-C4F1-4376-A77E-047987D70881,",
            email: "luis@keepcoding.es",
            password: "abcd1234",
            role: .trainee,
            profile: Profile (
                name: "Luis",
                goal: "Maratón de la Ciudad de México",
                age: 28,
                weight: 60,
                height: 1.54
            ))
    ]
    
    static let givenUserDTOs = [
        UserDTO(
            email: "nagumo@keepcoding.es",
            password: "abcd1234",
            role: .trainee,
            profile: ProfileDTO (
                name: "Ari",
                goal: "Maratón de la Ciudad de México",
                age: 28,
                weight: 60,
                height: 1.54
            )),
        UserDTO(
            email: "ana@keepcoding.es",
            password: "abcd1234",
            role: .trainee,
            profile: ProfileDTO (
                name: "Ana",
                goal: "Maratón de la Ciudad de México",
                age: 28,
                weight: 60,
                height: 1.54
            )),
        UserDTO(
            email: "luis@keepcoding.es",
            password: "abcd1234",
            role: .trainee,
            profile: ProfileDTO (
                name: "Luis",
                goal: "Maratón de la Ciudad de México",
                age: 28,
                weight: 60,
                height: 1.54
            ))
    ]
}
