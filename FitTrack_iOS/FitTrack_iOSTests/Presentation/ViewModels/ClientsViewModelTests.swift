//
//  ClientsViewModel.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 28/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class ClientsViewModelTests: XCTestCase {
    var sut: ClientsViewModelProtocol!
    var mockGetTraineesUseCase: MockGetTraineesUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockGetTraineesUseCase = MockGetTraineesUseCase()
        sut = ClientsViewModel(getTraineesUseCase: mockGetTraineesUseCase)
    }
    
    override func tearDownWithError() throws {
        mockGetTraineesUseCase = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_userDomain_mappedToItem() {
        // Given
        let user = UserData.givenUser
        
        // When
        let userItem = UserDomainToItemMapper().map(user)
        
        // Then
        XCTAssertEqual(user.profile.name, userItem.firstName)
    }
    
    func test_loadTrainees_Succeed() async throws {
        // Given
        mockGetTraineesUseCase.dataReceived = UserData.givenUsers
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
        
        sut.load()
        
        // Then
        await fulfillment(of: [loadingExpectation, loadedExpectation], timeout: 0.1)
        XCTAssertEqual(sut.clients.count, 3)
        XCTAssertEqual(sut.clients.first?.firstName, "Ari")
    }
    
    func test_loadTrainees_ShouldReturnEmpty() async throws {
        // Given
        mockGetTraineesUseCase.dataReceived = []
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
        
        sut.load()
        
        // Then
        await fulfillment(of: [loadingExpectation, loadedExpectation], timeout: 0.1)
        XCTAssertEqual(sut.clients.count, 0)
        XCTAssertNil(sut.clients.first?.firstName)
    }
}
