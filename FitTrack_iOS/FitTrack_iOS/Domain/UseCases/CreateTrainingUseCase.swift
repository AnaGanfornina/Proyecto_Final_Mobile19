//
//  CrateTrainingUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation

protocol CreateTrainingUseCaseProtocol {
    func run(name: String, goalId: UUID) async throws -> Training
}

final class CreateTrainingUseCase: CreateTrainingUseCaseProtocol {
    private let trainingRepository: TrainingRepository
    
    init(trainingRepository: TrainingRepository = TrainingRepository()) {
        self.trainingRepository = trainingRepository
    }
    
    func run(name: String, goalId: UUID) async throws -> Training {
        try await trainingRepository.create(name: name, goalId: goalId)
    }
}
