//
//  ExerciseRepository.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 28/9/25.
//

import Foundation

protocol ExerciseRepositoryProtocol {
    func getAll() async throws ->  [Exercise]
    
}

// MARK: - ExercidesRepositoryMock

final class ExerciseRepositoryMock: ExerciseRepositoryProtocol {
    
    func getAll() async throws -> [Exercise] {

        return ExercisesLoader().exercises
    }
}

