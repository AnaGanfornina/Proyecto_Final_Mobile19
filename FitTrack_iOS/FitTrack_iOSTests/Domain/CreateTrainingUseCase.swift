//
//  CreateTrainingUseCaseTests.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class CreateTrainingCaseTests: XCTestCase {
    var sut: CreateTrainingUseCaseProtocol!
    var mockTrainingReposiory: MockTrainingRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockTrainingReposiory = MockTrainingRepository()
        sut = CreateTrainingUseCase(trainingRepository: mockTrainingReposiory)
    }
    
    func testCreateTraining_ShouldReturnSuccess() async throws {
        // Given
        let trainingData = try XCTUnwrap(TrainingData.givenItem)
        mockTrainingReposiory.dataReceived = trainingData
        
        // When
        let training = try await sut.run(
            name: "Fuerza: Full Body",
            traineeId: UUID(uuidString: "E0D9DD1C-496F-4E9A-A944-44DB158A1679") ?? UUID()
        )
        
        // Then
        let unwrappedTraining = try XCTUnwrap(training)
        XCTAssertEqual(unwrappedTraining.id, UUID(uuidString: "DAB7C5C0-0579-4D01-A01D-002D3F6D8985"))
        XCTAssertEqual(unwrappedTraining.name, "Fuerza: Full Body")
        XCTAssertEqual(unwrappedTraining.coachId, UUID(uuidString: "E0D9DD1C-496F-4E9A-A944-44DB158A1679"))
    }
    
    func testCreateTraining_WhenDataIsCorrupted() async throws {
        // Given
        mockTrainingReposiory.dataReceived = nil
        
        // When
        var trainingError: AppError?
        do {
            let _ = try await sut.run(
                name: "Fuerza: Full Body",
                traineeId: UUID(uuidString: "E0D9DD1C-496F-4E9A-A944-44DB158A1679") ?? UUID()
            )
            XCTFail("Training error expected")
        } catch let error as AppError {
            trainingError = error
        }
        
        // Then
        XCTAssertNotNil(trainingError)
        XCTAssertEqual(trainingError?.reason, "The request could not be understood or was missing required parameters")
    }
}
