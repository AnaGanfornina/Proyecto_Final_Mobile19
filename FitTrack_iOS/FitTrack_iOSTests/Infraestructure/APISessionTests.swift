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
    
    func testUserDomainDTOToMapper() async throws {
        // Given
        let user = UserData.givenUser
        
        // When
        let userDTO = UserDomainToDTOMapper().map(user)
        
        // Then
        XCTAssertEqual(user.email, userDTO.email)
        XCTAssertEqual(user.password, userDTO.password)
        XCTAssertEqual(user.profile.name, userDTO.profile.name)
    }
    
    func testSignupURLRequest_ShouldSucceed() async throws {
        // Given
        var receivedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            receivedRequest = request
            let url = try XCTUnwrap(request.url)
            let httpResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url, statusCode: 200))
            let fileURL = try XCTUnwrap(Bundle(for: APISessionTests.self).url(forResource: "jwt", withExtension: "json"))
            let data = try XCTUnwrap(Data(contentsOf: fileURL))
            return (httpResponse, data)
        }
        
        // When
        let signupURLRequest = SignupURLRequest(userDTO: UserData.givenUserDTO)
        let signupData = try await sut.request(signupURLRequest)
        
        // Then
        XCTAssertEqual(receivedRequest?.url?.path(), "/api/auth/register/coach")
        XCTAssertEqual(receivedRequest?.httpMethod, "POST")
        XCTAssertNotNil(signupData)
    }
    
    func testLoginURLRequest_ShouldSucceed() async throws {
        // Given
        var receivedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            receivedRequest = request
            let url = try XCTUnwrap(request.url)
            let httpResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url, statusCode: 200))
            let fileURL = try XCTUnwrap(Bundle(for: APISessionTests.self).url(forResource: "jwt", withExtension: "json"))
            let data = try XCTUnwrap(Data(contentsOf: fileURL))
            return (httpResponse, data)
        }
        
        // When
        let loginURLRequest = LoginURLRequest(
            user: "adminuser@keepcoding.es",
            password: "abc12345"
        )
        let jwtData = try await sut.request(loginURLRequest)
        
        // Then
        XCTAssertEqual(receivedRequest?.url?.path(), "/api/auth/login")
        XCTAssertEqual(receivedRequest?.httpMethod, "POST")
        XCTAssertEqual(receivedRequest?.value(forHTTPHeaderField: "Authorization"), "Basic YWRtaW51c2VyQGtlZXBjb2RpbmcuZXM6YWJjMTIzNDU=")
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
            user: "adminuser@keepcoding.es",
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
    
    func testCreateTrainingURLRequest_ShouldSucceed() async throws {
        // Given
        var receivedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            receivedRequest = request
            let url = try XCTUnwrap(request.url)
            let httpResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url, statusCode: 200))
            let fileURL = try XCTUnwrap(Bundle(for: APISessionTests.self).url(forResource: "training", withExtension: "json"))
            let data = try XCTUnwrap(Data(contentsOf: fileURL))
            return (httpResponse, data)
        }
        
        // When
        let createTrainingURLRequest = CreateTrainingURLRequest(
            name: "Fuerza: Full Body",
            traineeId: UUID(uuidString: "E0D9DD1C-496F-4E9A-A944-44DB158A1679") ?? UUID(),
            scheduledAt: "2025-09-20T14:06:36Z"
        )
        let training = try await sut.request(createTrainingURLRequest)
        
        // Then
        XCTAssertEqual(receivedRequest?.url?.path(), "/api/trainings")
        XCTAssertEqual(receivedRequest?.httpMethod, "POST")
        let trainingDTO = try XCTUnwrap(training)
        XCTAssertEqual(trainingDTO.id, UUID(uuidString: "DAB7C5C0-0579-4D01-A01D-002D3F6D8985"))
        XCTAssertEqual(trainingDTO.name, "Fuerza: Full Body")
        XCTAssertEqual(trainingDTO.scheduledAt, "2025-09-20T14:06:36Z")
        XCTAssertEqual(trainingDTO.traineeId, UUID(uuidString: "E0D9DD1C-496F-4E9A-A944-44DB158A1679"))
    }
    
    func testCreateTrainingURLRequest_ShouldReturnError() async throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let request = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url, statusCode: 400))
            return (request, Data())
        }
        
        // When
        let createTrainingURLRequest = CreateTrainingURLRequest(
            name: "Fuerza: Full Body",
            traineeId: UUID(uuidString: "12345") ?? UUID(),
            scheduledAt: "2025-09-20T14:06:36Z"
        )
        
        var apiError: APIError?
        do {
            let _ = try await sut.request(createTrainingURLRequest)
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
        var receivedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            receivedRequest = request
            let url = try XCTUnwrap(request.url)
            let httpURLResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url))
            let fileURL = try XCTUnwrap(Bundle(for: TrainingRepositoryTests.self).url(forResource: "trainings", withExtension: "json"))
            let jwtData = try XCTUnwrap(Data(contentsOf: fileURL))
            return (httpURLResponse, jwtData)
        }
        
        // When
        let trainings = try await sut.request(
            GetTrainingsURLRequest(filter: nil)
        )
        
        // Then
        XCTAssertEqual(receivedRequest?.url?.path(), "/api/trainings")
        XCTAssertEqual(receivedRequest?.httpMethod, "GET")
        XCTAssertEqual(trainings.count, 3)
    }
    
    func testGetTrainingsByMonth_ShouldSucceed() async throws {
        // Given
        var receivedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            receivedRequest = request
            let url = try XCTUnwrap(request.url)
            let httpURLResponse = try XCTUnwrap(MockURLProtocol.httpURLResponse(url: url))
            let fileURL = try XCTUnwrap(Bundle(for: TrainingRepositoryTests.self).url(forResource: "trainings", withExtension: "json"))
            let jwtData = try XCTUnwrap(Data(contentsOf: fileURL))
            return (httpURLResponse, jwtData)
        }
        
        // When
        let trainings = try await sut.request(
            GetTrainingsByMonthURLRequest(9, year: 2025)
        )
        
        // Then
        XCTAssertEqual(receivedRequest?.url?.path(), "/api/trainings/byMonth")
        XCTAssertEqual(receivedRequest?.httpMethod, "GET")
        XCTAssertEqual(trainings.count, 3)
    }
}
