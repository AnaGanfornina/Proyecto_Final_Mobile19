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


//TODO: Add a protocol to be able to mock in the future
@Observable
final class ExercisesViewModel {
    private let getExercisesUseCase: GetExercisesUseCaseProtocol
    var exercisesItemList: [Exercise]
    var state: ExerciesViewState
    
    init(getExercisesUseCase: GetExercisesUseCaseProtocol = GetExercisesUseCase()) {
        self.getExercisesUseCase = getExercisesUseCase
        state = .none
        exercisesItemList = []
    }
    
    func getAll() {
        state = .loading
        
        Task { @MainActor in
            do {
                exercisesItemList = try await getExercisesUseCase.run()
                state = .loaded
            } catch {
                state = .error
            }
        }
        
    }
        
}
