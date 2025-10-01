//
//  GetSessionUseCaseTests.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class GetSessionUseCaseTests: XCTestCase {
    var sut: GetSessionUseCaseProtocol!
    var mockAuthRepository: MockAuthRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAuthRepository = MockAuthRepository()
        sut = GetSessionUseCase(authRepository: mockAuthRepository)
    }
    
    override func tearDownWithError() throws {
        mockAuthRepository = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGetSession_WhenIsSuccess() async throws {
        // Given
        let fileURL = try XCTUnwrap(Bundle(for: GetSessionUseCaseTests.self).url(forResource: "jwt", withExtension: "json"))
        let jwtData = try XCTUnwrap(Data(contentsOf: fileURL))
        mockAuthRepository.receivedData = jwtData
        
        // When
        let successResponse: () = try await sut.run()
        
        // Then
        XCTAssertNotNil(successResponse)
    }
    
    func testGetSession_WhenIsError() async throws {
        // When
        var sessionError: AppError?
        do {
            let _ = try await sut.run()
        } catch let error as AppError {
            sessionError = error
        }
        
        // Then
        XCTAssertNotNil(sessionError)
        XCTAssertEqual(sessionError?.reason, "Session not found or expired, log in again")
    }
}
