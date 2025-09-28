//
//  GetTrainingByMonthUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 27/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class GetTrainingsByMonthUseCaseTests: XCTestCase {
    var sut: GetTrainingsByMonthUseCaseProtocol!
    var mockTrainingRepository: MockTrainingRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockTrainingRepository = MockTrainingRepository()
        sut = GetTrainingsByMonthUseCase(trainingRepository: mockTrainingRepository)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockTrainingRepository = nil
        try super.tearDownWithError()
    }
    
    func testGetTrainingsByMonth_ShouldSuccess() async throws {
        // Given
        let trainingListData = try XCTUnwrap(TrainingData.givenList)
        mockTrainingRepository.trainingListRecived = trainingListData
        
        // When
        let trainingList = try await sut.run(month: 9, year: 2025)
        
        // Then
        XCTAssertEqual(trainingList.count, 3)
        let unwrappedTraining = try XCTUnwrap(trainingList.first)
        XCTAssertEqual(unwrappedTraining.id, UUID(uuidString: "81493846-95EB-4EB6-8343-B89BCB87C475"))
        XCTAssertEqual(unwrappedTraining.name, "Fuerza: Full Body")
    }
    
    func testGetTrainingsByMonth_ShouldReturnEmpty() async throws {
        // Given
        let trainingListData = try XCTUnwrap(TrainingData.givenList)
        mockTrainingRepository.trainingListRecived = trainingListData
        
        // When
        let trainingList = try await sut.run(month: 10, year: 2025)
        
        // Then
        XCTAssertEqual(trainingList.count, 0)
    }
}
