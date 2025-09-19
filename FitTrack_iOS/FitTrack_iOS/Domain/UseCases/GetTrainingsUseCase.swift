//
//  GetTrainingsUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation

protocol GetTrainingsUseCaseProtocol {
    func run() async throws -> [Training]
}

final class GetTrainingsUseCase: GetTrainingsUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func run() async throws -> [Training] {
        try await userRepository.getTrainings()
    }
}
