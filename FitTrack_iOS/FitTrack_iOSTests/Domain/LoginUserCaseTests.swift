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
    var mockLoginRepository: MockLoginRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockLoginRepository = MockLoginRepository()
        sut = LoginUseCase(repository: mockLoginRepository)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockLoginRepository = nil
        try super.tearDownWithError()
    }
    
    /// Test para comprobar que el login se ha hecho correctamente, pues este devuele true
    func test_login_ReturnSuccess() async throws{
        // Given
        let fileURL = try XCTUnwrap(Bundle(for: LoginUserCaseTests.self).url(forResource: "jwt", withExtension: "txt"))
        let data = try XCTUnwrap(Data(contentsOf: fileURL))
        mockLoginRepository.receivedData = data
        
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
