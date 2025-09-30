//
//  TrainingViewModelTests.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 29/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class TrainingViewModelTests: XCTestCase {
    var sut: TrainingViewModelProtocol!
    var mockGetTraineesUseCase: MockGetTraineesUseCase!
    var mockGetTrainingsUseCase: MockGetTrainingsUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockGetTraineesUseCase = MockGetTraineesUseCase()
        mockGetTrainingsUseCase = MockGetTrainingsUseCase()
        sut = TrainingViewModel(getTrainingsUseCase: mockGetTrainingsUseCase,
                                getTraineesUseCase: mockGetTraineesUseCase)
    }
    
    override func tearDownWithError() throws {
        mockGetTraineesUseCase = nil
        mockGetTrainingsUseCase = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_trainingDomain_mappedToItem() {
        // Given
        let user = UserData.givenUser
        let training = TrainingData.givenItem
        
        // When
        let item = TrainingDomainToItemMapper().map(training, user: user)
        
        // Then
        XCTAssertEqual(item.id, training.id)
        XCTAssertEqual(item.userITem.firstName, user.profile.name)
    }
    
    func test_getAll_Succeed() async throws {
        // Given
        mockGetTraineesUseCase.dataReceived = UserData.givenUsers
        mockGetTrainingsUseCase.dataReceived = TrainingData.givenList
        let loadingExpectation = expectation(description: "Loading state succeed")
        let loadedExpectation = expectation(description: "Loaded state succeed")
        
        // When
        sut.onStateChanged = { state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .loaded:
                loadedExpectation.fulfill()
            default:
                XCTFail("Loaded state is expected")
            }
        }
        
        sut.getAll(isHomeEntrypoint: true)
        
        // Then
        await fulfillment(of: [loadingExpectation, loadedExpectation], timeout: 0.1)
        XCTAssert(mockGetTraineesUseCase.getTraineesCalled)
        XCTAssert(mockGetTrainingsUseCase.getTrainingsCalled)
        XCTAssertEqual(sut.trainingItemList.count, 4)
        XCTAssertEqual(sut.trainingItemList.first?.userITem.firstName, "Ari")
    }
    
    func test_getAll_ShouldReturnEmpty() async throws {
        // Given
        mockGetTraineesUseCase.dataReceived = []
        mockGetTrainingsUseCase.dataReceived = []
        let loadingExpectation = expectation(description: "Loading state succeed")
        let loadedExpectation = expectation(description: "Loaded state succeed")
        
        // When
        sut.onStateChanged = { state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .loaded:
                loadedExpectation.fulfill()
            default:
                XCTFail("Loaded state is expected")
            }
        }
        
        sut.getAll(isHomeEntrypoint: true)
        
        // Then
        await fulfillment(of: [loadingExpectation, loadedExpectation], timeout: 0.1)
        XCTAssert(mockGetTraineesUseCase.getTraineesCalled)
        XCTAssert(mockGetTrainingsUseCase.getTrainingsCalled)
        XCTAssertEqual(sut.trainingItemList.count, 0)
        XCTAssertNil(sut.trainingItemList.first?.userITem.firstName)
    }
}
