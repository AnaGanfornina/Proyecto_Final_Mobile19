//
//  SignupUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

protocol SignupUseCaseProtocol {
    func run(user: User)  async throws
}

final class SignupUseCase: SignupUseCaseProtocol {
    private let authRepository: any AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    func run(user: User) async throws {
        let _ = try RegexLint.validate(data: user.email, matchWith: .email)
        let _ = try RegexLint.validate(data: user.password, matchWith: .password)
        try await authRepository.signup(user: user)
    }
}
