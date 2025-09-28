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
        
        // When
        sut.load()
        try await Task.sleep(for: .seconds(0.1))
        
        // Then
        XCTAssertEqual(sut.clients.count, 3)
        XCTAssertEqual(sut.clients.first?.firstName, "Ari")
    }
    
    func test_loadTrainees_ShouldReturnEmpty() async throws {
        // Given
        mockGetTraineesUseCase.dataReceived = []
        
        // When
        sut.load()
        try await Task.sleep(for: .seconds(0.1))
        
        // Then
        XCTAssertEqual(sut.clients.count, 0)
        XCTAssertNil(sut.clients.first?.firstName)
    }
}
