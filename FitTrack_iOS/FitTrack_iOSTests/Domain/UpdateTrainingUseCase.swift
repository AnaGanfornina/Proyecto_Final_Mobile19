//
//  UpdateTrainingUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 27/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class UpdateTrainingCaseTests: XCTestCase {
    var sut: UpdateTrainingUseCaseProtocol!
    var mockTrainingReposiory: MockTrainingRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockTrainingReposiory = MockTrainingRepository()
        sut = UpdateTrainingUseCase(trainingRepository: mockTrainingReposiory)
    }
    
    func test_updateTraining_ShouldReturnSuccess() async throws {
        // Given
        let trainingData = try XCTUnwrap(TrainingData.givenItem)
        mockTrainingReposiory.dataReceived = trainingData
        
        // When
        let training = try await sut.run(training: trainingData)
        
        // Then
        let unwrappedTraining = try XCTUnwrap(training)
        XCTAssertEqual(unwrappedTraining.id, UUID(uuidString: "DAB7C5C0-0579-4D01-A01D-002D3F6D8985"))
        XCTAssertEqual(unwrappedTraining.name, "Fuerza: Full Body")
    }
    
    func test_updateTraining_WhenDataIsCorrupted() async throws {
        // Given
        mockTrainingReposiory.dataReceived = nil
        
        // When
        var trainingError: AppError?
        do {
            let _ = try await sut.run(training: TrainingData.givenItem)
            XCTFail("Training error expected")
        } catch let error as AppError {
            trainingError = error
        }
        
        // Then
        XCTAssertNotNil(trainingError)
        XCTAssertEqual(trainingError?.reason, "The request could not be understood or was missing required parameters")
    }
}
