//
//  LoginRepositoryTests.swift
//  FitTrack_iOSTests
//
//  Created by Ana Ganfornina Arques on 8/9/25.
//

import XCTest
@testable import FitTrack_iOS

final class LoginRepositoryTests: XCTestCase {
    var sut: LoginRepositoryProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let mockApiSession = APISession(urlSession: urlSession)
        sut = LoginRepository(
            apiSession: mockApiSession,
            authDatasource: MockAuthDataSource()
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testLogin_WhenCredentialsAreValid_ShouldSucceed() async throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let httpURLResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url))
            let fileURL = try XCTUnwrap(Bundle(for: LoginRepositoryTests.self).url(forResource: "jwt", withExtension: "txt"))
            let jwtData = try XCTUnwrap(Data(contentsOf: fileURL))
            return (httpURLResponse, jwtData)
        }
        
        // When
        let successResponse: () = try await sut.login(
            user: "adminuser@keepcoding.es",
            password: "abc12345"
        )
        
        // Then
        XCTAssertNotNil(successResponse)
    }
    
    func testLogin_WhenCredentialsAreWrong_ShouldRetunUnauthorizedError() async throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let httpURLResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url, statusCode: 401))
            return (httpURLResponse, Data())
        }
        
        // When
        var loginError: APIError?
        do {
            try await sut.login(user: "adminuser@keepcoding.es", password: "abc")
        } catch let error as APIError? {
            loginError = error
        }
        
        // Then
        XCTAssertNotNil(loginError)
        XCTAssertEqual(loginError?.reason, "Wrong email or password. Please log in again.")
    }
}
