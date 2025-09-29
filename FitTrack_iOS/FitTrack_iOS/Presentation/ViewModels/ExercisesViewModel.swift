//
//  ExercisesViewModel.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 29/9/25.
//

import Foundation

enum ExerciesViewState: Equatable {
    case none, loading, loaded, error
}

@Observable
final class ExercisesViewModel {
    private let getExercisesUseCase: GetExercisesUseCaseProtocol
    var trainingItemList: [Exercise]
    var state: ExerciesViewState
    
    init(getExercisesUseCase: GetExercisesUseCaseProtocol = GetExercisesUseCase()) {
        self.getExercisesUseCase = getExercisesUseCase
        state = .none
        trainingItemList = []
    }
    
    func getAll() {
        state = .loading
        
        Task { @MainActor in
            do {
                trainingItemList = try await getExercisesUseCase.run()
                state = .loaded
            } catch {
                state = .error
            }
        }
        
    }
        
}
