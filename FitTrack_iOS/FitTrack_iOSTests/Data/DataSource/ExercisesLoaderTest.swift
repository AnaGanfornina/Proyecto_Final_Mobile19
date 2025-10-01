//
//  ExercisesLoaderTest.swift
//  FitTrack_iOSTests
//
//  Created by Ana Ganfornina Arques on 28/9/25.
//

import XCTest
@testable import FitTrack_iOS

final class ExercisesLoaderTest: XCTestCase {
    var sut: ExercisesLoader!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ExercisesLoader ()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testLoadData_ShouldReturnSuccess() throws {
        // Given
        var expectedExercise: [Exercise] = []
        
        // When
        expectedExercise = try XCTUnwrap(sut.loadData())
        
        // Then

        XCTAssertEqual(expectedExercise.count, 7)
        let exercise = try XCTUnwrap(expectedExercise.first)
        XCTAssertEqual(exercise.name, "Bench Press")
        XCTAssertEqual(exercise.id, "11111111-1111-1111-1111-111111111111")
        XCTAssertEqual(exercise.muscleGroup, "Chest")
        XCTAssertEqual(exercise.category, "Barbell")
    }

    

}
