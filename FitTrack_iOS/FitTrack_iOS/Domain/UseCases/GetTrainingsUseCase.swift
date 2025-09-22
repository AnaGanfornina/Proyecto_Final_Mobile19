//
//  GetTrainingsUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation

protocol GetTrainingsUseCaseProtocol {
    func run(filter: String?) async throws -> [Training]
}

final class GetTrainingsUseCase: GetTrainingsUseCaseProtocol {
    private let trainingRepository: TrainingRepositoryProtocol
    
    init(trainingRepository: TrainingRepositoryProtocol) {
        self.trainingRepository = trainingRepository
    }
    
    func run(filter: String?) async throws -> [Training] {
        try await trainingRepository.getAll(filter: filter)
    }
}
