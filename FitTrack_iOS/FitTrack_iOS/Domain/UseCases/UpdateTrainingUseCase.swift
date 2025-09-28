//
//  UpdateTrainingUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 26/09/25.
//

import Foundation

protocol UpdateTrainingUseCaseProtocol {
    func run(training: Training) async throws -> Training
}

final class UpdateTrainingUseCase: UpdateTrainingUseCaseProtocol {
    private let trainingRepository: TrainingRepositoryProtocol
    
    init(trainingRepository: TrainingRepositoryProtocol = TrainingRepository()) {
        self.trainingRepository = trainingRepository
    }
    
    func run(training: Training) async throws -> Training {
        try await trainingRepository.update(training: training)
    }
}
