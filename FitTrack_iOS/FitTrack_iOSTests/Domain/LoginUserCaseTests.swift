//
//  LoginUserCaseTest.swift
//  FitTrack_iOSTests
//
//  Created by Ana Ganfornina Arques on 8/9/25.
//

import XCTest
@testable import FitTrack_iOS

final class LoginUserCaseTests: XCTestCase {
    var sut: LoginUseCaseProtocol!
    var mockAuthRepository: MockAuthRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAuthRepository = MockAuthRepository()
        sut = LoginUseCase(repository: mockAuthRepository)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockAuthRepository = nil
        try super.tearDownWithError()
    }
    
    /// Test para comprobar que el login se ha hecho correctamente, pues este devuele true
    func testLogin_ReturnSuccess() async throws{
        // Given
        let fileURL = try XCTUnwrap(Bundle(for: LoginUserCaseTests.self).url(forResource: "jwt", withExtension: "json"))
        let data = try XCTUnwrap(Data(contentsOf: fileURL))
        mockAuthRepository.receivedData = data
        
        // When
        let successResponse: () = try await sut.run(user: "regularuser@keepcoding.es", password: "Regularuser1")
        
        // Then
        XCTAssertNotNil(successResponse)
    }
    
    func testLogin_WhenCredentialsAreInvalid_ShouldReturnRegexError() async throws {
        // When
        var loginError: RegexLintError?
        do {
            let _ = try await sut.run(user: "regularuser", password: "Regularuser1")
        } catch let error as RegexLintError {
            loginError = error
        }
        
        // Then
        XCTAssertNotNil(loginError)
        XCTAssertEqual(loginError, .email)
    }
    
    func testLogin_WhenCredentialsAreWrong_ShouldRetunUnauthorizedError() async throws {
        // When
        var loginError: AppError?
        do {
            let _ = try await sut.run(user: "regularuser@keepcoding.es", password: "Regularuser13")
        } catch let error as AppError {
            loginError = error
        }
        
        // Then
        XCTAssertNotNil(loginError)
        XCTAssertEqual(loginError?.reason, "Failed to save session, try again")
    }
}
