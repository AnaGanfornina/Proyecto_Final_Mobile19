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
    private let getTrainingsUseCase: GetTrainingsUseCaseProtocol
    var state: TrainingViewState
    
    init(createTrainingUseCase: CreateTrainingUseCaseProtocol = CreateTrainingUseCase(),
         getTrainingsUseCase: GetTrainingsUseCaseProtocol = GetTrainingsUseCase()) {
        self.createTrainingUseCase = createTrainingUseCase
        self.getTrainingsUseCase = getTrainingsUseCase
        state = .none
    }
    
    func getAll(isHomeEntrypoint: Bool) {
        state = .loading
        
        Task { @MainActor in
            do {
                let trainings = try await getTrainingsUseCase.run(
                    filter: isHomeEntrypoint ? "today" : nil
                )
                state = .loaded
            } catch {
                AppLogger.debug(error.localizedDescription)
                state = .error
            }
        }
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

