//
//  GetTrainingsUseCaseTests.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 21/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class GetTrainingsUseCaseTests: XCTestCase {
    var sut: GetTrainingsUseCaseProtocol!
    var mockTrainingRepository: MockTrainingRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockTrainingRepository = MockTrainingRepository()
        sut = GetTrainingsUseCase(trainingRepository: mockTrainingRepository)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockTrainingRepository = nil
        try super.tearDownWithError()
    }
    
    func testGetTrainings_ShouldSuccess() async throws {
        // Given
        let trainingListData = try XCTUnwrap(TrainingData.givenList)
        mockTrainingRepository.trainingListRecived = trainingListData
        
        // When
        let trainingList = try await sut.run(filter: nil)
        
        // Then
        XCTAssertEqual(trainingList.count, 3)
        let unwrappedTraining = try XCTUnwrap(trainingList.first)
        XCTAssertEqual(unwrappedTraining.id, UUID(uuidString: "81493846-95EB-4EB6-8343-B89BCB87C475"))
        XCTAssertEqual(unwrappedTraining.name, "Fuerza: Full Body")
    }
    
    func testGetTrainings_WithFilterToday_ShouldSuccess() async throws {
        // Given
        let trainingListData = try XCTUnwrap(TrainingData.givenList)
        mockTrainingRepository.trainingListRecived = trainingListData
        
        // When
        let trainingList = try await sut.run(filter: "today")
        
        // Then
        XCTAssertEqual(trainingList.count, 1)
        let todayTraining = try XCTUnwrap(trainingList.first)
        XCTAssertEqual(todayTraining.id, UUID(uuidString: "C9A2DC6E-1B69-406F-88AC-55AAABF677BF"))
        XCTAssertEqual(todayTraining.name, "Fuerza: Full Body")
    }
}
