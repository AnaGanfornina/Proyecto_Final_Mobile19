//
//  UserRepositoryTests.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 24/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class UserRepositoryTests: XCTestCase {
    var sut: UserRepositoryProtocol!
    var mockAPISession: MockAPISession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPISession = MockAPISession()
        sut = UserRepository(apiSession: mockAPISession)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockAPISession = nil
        try super.tearDownWithError()
    }
    
    func test_userDomain_mappedToDTO() async throws {
        // Given
        let userDomain = UserData.givenUser
        
        // When
        let userDTO = UserDomainToDTOMapper().map(userDomain)
        
        // Then
        XCTAssertEqual(userDomain.email, userDTO.email)
        XCTAssertEqual(userDomain.password, userDTO.password)
        XCTAssertEqual(userDomain.role.rawValue, userDTO.role.rawValue)
        XCTAssertEqual(userDomain.profile.name, userDTO.profile.name)
    }
    
    func test_signup_request_succeed() async throws {
        // Given
        let usersDTOs = UserData.givenUserDTOs
        let data = try JSONEncoder().encode(usersDTOs)
        
        mockAPISession.receivedResponse = try JSONDecoder().decode([UserDTO].self, from: data)
        
        // When
        let users = try await sut.getTrainees()
        
        // Then
        XCTAssert(mockAPISession.requestCalled)
        XCTAssertNotNil(users)
    }
    
    func test_signup_request_failed() async throws {
        // Given
        mockAPISession.receivedError = APIError.badRequest(url: "/api/auth/register", statusCode: 400)
        
        // When / Then
        do {
            let _  = try await sut.getTrainees()
            XCTFail("Expected badRequest error")
        } catch let error as APIError {
            XCTAssertEqual(error.url, "/api/auth/register")
            XCTAssertEqual(error.reason, "The request could not be understood or was missing required parameters")
            XCTAssertEqual(error.statusCode, 400)
        } catch {
            XCTFail("Expected badRequestError")
        }
    }
}
