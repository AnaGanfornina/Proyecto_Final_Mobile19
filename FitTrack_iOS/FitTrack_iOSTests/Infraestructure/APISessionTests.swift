//
//  APISessionTests.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 17/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class APISessionTests: XCTestCase {
    var sut: APISessionContract!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        sut = APISession(urlSession: urlSession)
    }
    
    override func tearDownWithError() throws {
        MockURLProtocol.requestHandler = nil
        MockURLProtocol.error = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testLoginURLRequest() async throws {
        // Given
        var receivedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            receivedRequest = request
            let url = try XCTUnwrap(request.url)
            let httpResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url, statusCode: 200))
            let fileURL = try XCTUnwrap(Bundle(for: APISessionTests.self).url(forResource: "jwt", withExtension: "txt"))
            let data = try XCTUnwrap(Data(contentsOf: fileURL))
            return (httpResponse, data)
        }
        
        // When
        let loginURLRequest = LoginURLRequest(
            user: "alvaro@gmail.com", 
            password: "abc12345"
        )
        let jwtData = try await sut.request(loginURLRequest)
        
        // Then
        XCTAssertEqual(receivedRequest?.url?.path(), "/api/auth/login")
        XCTAssertEqual(receivedRequest?.httpMethod, "POST")
        XCTAssertEqual(receivedRequest?.url?.path(), "/api/auth/login")
        XCTAssertEqual(receivedRequest?.value(forHTTPHeaderField: "Authorization"), "Basic YWx2YXJvQGdtYWlsLmNvbTphYmMxMjM0NQ==")
        XCTAssertNotNil(jwtData)
    }
    
    func testLoginURLRequest_ShouldReturnError() async throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let request = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url, statusCode: 401))
            return (request, Data())
        }
        
        // When
        let loginURLRequest = LoginURLRequest(
            user: "alvaro@gmail.com",
            password: "abc12345"
        )
        
        var apiError: APIError?
        do {
            let _ = try await sut.request(loginURLRequest)
            XCTFail("Login error expected")
        } catch let error as APIError {
            apiError = error
        }
        
        // Then
        let unauthorizedAPIError = try XCTUnwrap(apiError)
        XCTAssertEqual(unauthorizedAPIError.url, "/api/auth/login")
        XCTAssertEqual(unauthorizedAPIError.reason, "Wrong email or password. Please log in again.")
        XCTAssertEqual(unauthorizedAPIError.statusCode, 401)
    }
}
