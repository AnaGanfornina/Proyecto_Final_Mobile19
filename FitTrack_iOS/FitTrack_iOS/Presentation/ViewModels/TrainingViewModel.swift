//
//  TrainingViewModel.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 21/09/25.
//

import Foundation
import Combine

enum TrainingViewState: Equatable {
    case none, loading, loaded, error
}

@Observable final class TrainingViewModel {
    private let createTrainingUseCase: CreateTrainingUseCaseProtocol
    var state: TrainingViewState
    
    init(createTrainingUseCase: CreateTrainingUseCaseProtocol = CreateTrainingUseCase()) {
        self.createTrainingUseCase = createTrainingUseCase
        state = .none
    }
    
    func create(name: String, traineeId: UUID, scheduledAt: Date) {
        state = .loading
        
        Task { @MainActor in
            do {
                let _ = try await createTrainingUseCase.run(
                    name: name,
                    traineeId: traineeId,
                    scheduledAt: scheduledAt.ISO8601Format() // Format required for the server
                )
                state = .loaded
            } catch {
                state = .error
            }
        }
    }
}

