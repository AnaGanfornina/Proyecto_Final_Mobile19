//
//  MockLoginUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation
@testable import FitTrack_iOS

// MARK: -  LoginUseCaseMock
final class LoginUseCaseMock: LoginUseCaseProtocol {
    
    let repository: LoginRepositoryProtocol
    
    init(repository: LoginRepositoryProtocol = LoginRepository()) {
        self.repository = repository
    }
    
    func run(user: String, password: String) async throws {
        try await repository.login(user: user, password: password)
    }
    
    func hasValidSession() async -> Bool {
        return true
    }
}
