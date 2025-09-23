//
//  SignupUseCaseTests.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class SignupUseCaseTests: XCTestCase {
    var sut: SignupUseCaseProtocol!
    var mockAuthRepository: MockAuthRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAuthRepository = MockAuthRepository()
        sut = SignupUseCase(authRepository: mockAuthRepository)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockAuthRepository = nil
        try super.tearDownWithError()
    }
    
    func testSignup_ReturnSuccess() async throws{
        // Given
        let user = UserData.givenUser
        let fileURL = try XCTUnwrap(Bundle(for: SignupUseCaseTests.self).url(forResource: "jwt", withExtension: "json"))
        let data = try XCTUnwrap(Data(contentsOf: fileURL))
        mockAuthRepository.receivedData = data
        
        // When
        let successResponse: () = try await sut.run(user: user)
        
        // Then
        XCTAssertNotNil(successResponse)
    }
    
    func testSignup_WhenCredentialsAreInvalid_ShouldReturnRegexError() async throws {
        // Given
        let user = UserData.givenUserWithWrongEmail
        
        // When
        var signupError: RegexLintError?
        do {
            let _ = try await sut.run(user: user)
        } catch let error as RegexLintError {
            signupError = error
        }
        
        // Then
        XCTAssertNotNil(signupError)
        XCTAssertEqual(signupError, .email)
    }
}
