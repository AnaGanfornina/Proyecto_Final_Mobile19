//
//  LoginUserCase.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 7/9/25.
//

import Foundation

protocol LoginUseCaseProtocol {
    func run(user: String, password: String)  async throws
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let repository: LoginRepositoryProtocol
    
    init(repository: LoginRepositoryProtocol = LoginRepository()) {
        self.repository = repository
    }
    
    func run(user: String, password: String) async throws {
        let user = try RegexLint.validate(data: user, matchWith: .email)
        let password = try RegexLint.validate(data: password, matchWith: .password)
        try await repository.login(user: user, password: password)
    }
}
