//
//  GetExercisesUseCaseTest.swift
//  FitTrack_iOSTests
//
//  Created by Ana Ganfornina Arques on 28/9/25.
//

import XCTest
@testable import FitTrack_iOS

final class GetExercisesUseCaseTest: XCTestCase {
    
    var sut: GetExercisesUseCaseProtocol!
    var mockExerciseReposiory: ExerciseRepositoryProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockExerciseReposiory =  ExerciseRepositoryMock()
        sut = GetExercisesUseCase(exerciseRepository: mockExerciseReposiory)
        
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_GetExercisesUseCase_ReturnExercises() async throws {
        // Given
        var expectedExercise: [Exercise] = []
        
        // When
        expectedExercise = try await sut.run()
        
        // Then

        XCTAssertEqual(expectedExercise.count, 6)
        let exercise = try XCTUnwrap(expectedExercise.first)
        XCTAssertEqual(exercise.name, "Bench Press")
        XCTAssertEqual(exercise.id, "11111111-1111-1111-1111-111111111111")
        XCTAssertEqual(exercise.muscleGroup, "Chest")
        XCTAssertEqual(exercise.category, "Barbell")
        
    }
}
