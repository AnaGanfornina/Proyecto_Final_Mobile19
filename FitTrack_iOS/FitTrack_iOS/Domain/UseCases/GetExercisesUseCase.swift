//
//  GetExercisesUseCase.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 28/9/25.
//


protocol GetExercisesUseCaseProtocol {
    func run() async throws -> [Exercise]
}


final class GetExercisesUseCase: GetExercisesUseCaseProtocol {

    private let exerciseRepository: ExerciseRepositoryProtocol
    
    //TODO: Change ExerciseRepositoryMock in the future for BD Data
    init(exerciseRepository: ExerciseRepositoryProtocol = ExerciseRepositoryMock()) {
        self.exerciseRepository = exerciseRepository
    }
    
    func run() async throws -> [Exercise] {
        try await exerciseRepository.getAll()
    }
}
