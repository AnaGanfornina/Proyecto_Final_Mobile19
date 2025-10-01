//
//  TrainingViewModel.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 21/09/25.
//

import Foundation
import Combine

enum TrainingViewState: Equatable {
    case none, loading, loaded, created, error
}

protocol TrainingViewModelProtocol {
    var onStateChanged: ((TrainingViewState) -> Void)? { get set } // Testing propuse
    var trainingItemList: [TrainingItem] { get }
    func getAll(isHomeEntrypoint: Bool)
    func create(name: String, traineeId: UUID, scheduledAt: Date)
}

@Observable
final class TrainingViewModel: TrainingViewModelProtocol {
    private let createTrainingUseCase: CreateTrainingUseCaseProtocol
    private let getTrainingsUseCase: GetTrainingsUseCaseProtocol
    private let getTraineesUseCase: GetTraineesUseCaseProtocol
    var state: TrainingViewState = .none {
        didSet { onStateChanged?(state) }
    }
    var onStateChanged: ((TrainingViewState) -> Void)?
    var trainingItemList: [TrainingItem]
    
    init(createTrainingUseCase: CreateTrainingUseCaseProtocol = CreateTrainingUseCase(),
         getTrainingsUseCase: GetTrainingsUseCaseProtocol = GetTrainingsUseCase(),
         getTraineesUseCase: GetTraineesUseCaseProtocol = GetTraineesUseCase()) {
        self.createTrainingUseCase = createTrainingUseCase
        self.getTrainingsUseCase = getTrainingsUseCase
        self.getTraineesUseCase = getTraineesUseCase
        state = .none
        trainingItemList = []
    }
    
    func getAll(isHomeEntrypoint: Bool) {
        state = .loading
        
        Task { @MainActor in
            do {
                let trainees = try await getTraineesUseCase.run()
                let trainings = try await getTrainingsUseCase.run(
                    filter: isHomeEntrypoint ? "today" : nil
                )
                
                trainingItemList = trainings.flatMap { training in
                    trainees.compactMap { trainee in
                        if training.traineeId?.uuidString == trainee.id {
                            return TrainingDomainToItemMapper().map(
                                training,
                                user: trainee
                            )
                        } else {
                            return nil
                        }
                    }
                }
                
                state = .loaded
            } catch {
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
                state = .created
            } catch {
                state = .error
            }
        }
    }
}

