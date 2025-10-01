//
//  GetTraineesUseCaseTests.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 24/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class GetTraineesUseCaseTests: XCTestCase {
    var sut: GetTraineesUseCaseProtocol!
    var mockUserRepository: MockUserRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUserRepository = MockUserRepository()
        sut = GetTraineesUseCase(userRepository: mockUserRepository)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockUserRepository = nil
        sut = nil
    }
    
    func test_callToRepository_andSucceed() async throws {
        // Given
        mockUserRepository.receivedUsers = UserData.givenUsers
        
        // When
        let users = try await sut.run()
        
        // Then
        XCTAssertTrue(mockUserRepository.getTraineesCalled)
        XCTAssertNotNil(users)
        XCTAssertEqual(users.count, 3)
        XCTAssertEqual(users.first?.email, "nagumo@keepcoding.es")
        XCTAssertEqual(users.first?.profile.goal, "Maratón de la Ciudad de México")
    }
    
    func test_callToRepository_andFailed() async throws {
        // Given
        mockUserRepository.receivedUsers = nil
        
        // When
        var apiError: APIError?
        do {
            let _ = try await sut.run()
        } catch let error as APIError {
            apiError = error
        }
        
        // Then
        XCTAssertTrue(mockUserRepository.getTraineesCalled)
        XCTAssertNotNil(apiError)
    }
}
