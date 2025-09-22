//
//  TrainingRepositoryTests.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class TrainingRepositoryTests: XCTestCase {
    var sut: TrainingRepositoryProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let mockApiSession = APISession(urlSession: urlSession)
        sut = TrainingRepository(apiSession: mockApiSession)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testCreateTraining_ShouldSucceed() async throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let httpURLResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url))
            let fileURL = try XCTUnwrap(Bundle(for: TrainingRepositoryTests.self).url(forResource: "training", withExtension: "json"))
            let jwtData = try XCTUnwrap(Data(contentsOf: fileURL))
            return (httpURLResponse, jwtData)
        }
        
        // When
        let training = try await sut.create(
            name: "Fuerza: Full Body",
            traineeId: UUID(uuidString: "E0D9DD1C-496F-4E9A-A944-44DB158A1679") ?? UUID(),
            scheduledAt: "2025-09-20T14:06:36Z"
        )
        
        // Then
        let unwrappedTraining = try XCTUnwrap(training)
        XCTAssertEqual(unwrappedTraining.id, UUID(uuidString: "DAB7C5C0-0579-4D01-A01D-002D3F6D8985"))
        XCTAssertEqual(unwrappedTraining.name, "Fuerza: Full Body")
        XCTAssertEqual(unwrappedTraining.scheduledAt, "2025-09-20T14:06:36Z")
    }
    
    func testCreateTraining_ShouldReturnError() async throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let request = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url, statusCode: 400))
            return (request, Data())
        }
        
        // When
        var apiError: APIError?
        do {
            let _ = try await sut.create(
                name: "Fuerza: Full Body",
                traineeId: UUID(uuidString: "E0D9DD1C-496F-4E9A-A944-44DB158A1679") ?? UUID(),
                scheduledAt: "2025-09-20T14:06:36Z"
            )
            XCTFail("Training error expected")
        } catch let error as APIError {
            apiError = error
        }
        
        // Then
        let badRequestAPIError = try XCTUnwrap(apiError)
        XCTAssertEqual(badRequestAPIError.url, "/api/trainings")
        XCTAssertEqual(badRequestAPIError.reason, "The request could not be understood or was missing required parameters")
        XCTAssertEqual(badRequestAPIError.statusCode, 400)
    }
    
    func testGetTrainings_ShouldSucceed() async throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let httpURLResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url))
            let fileURL = try XCTUnwrap(Bundle(for: TrainingRepositoryTests.self).url(forResource: "trainings", withExtension: "json"))
            let jwtData = try XCTUnwrap(Data(contentsOf: fileURL))
            return (httpURLResponse, jwtData)
        }
        
        // When
        let trainings = try await sut.getAll(filter: nil)
        
        // Then
        let unwrappedTrainingList = try XCTUnwrap(trainings)
        XCTAssertEqual(unwrappedTrainingList.count, 3)
    }
}
