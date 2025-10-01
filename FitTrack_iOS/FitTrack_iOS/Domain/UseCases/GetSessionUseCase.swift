//
//  GetSessionUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation

protocol GetSessionUseCaseProtocol {
    func run() async throws
}

final class GetSessionUseCase: GetSessionUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    func run() async throws {
        let _ = try await authRepository.getSession()
    }
}
