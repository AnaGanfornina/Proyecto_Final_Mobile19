//
//  MockApiSession.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 24/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class MockAPISession: APISessionContract {
    var requestCalled = false
    var receivedResponse: Decodable?
    var receivedError: Error?
    
    func request<URLRequest: URLRequestComponents>(_ request: URLRequest) async throws -> URLRequest.Response {
        requestCalled = true
        
        if let receivedError {
            throw receivedError
        }
        
        if let receivedResponse = receivedResponse as? URLRequest.Response {
            return receivedResponse
        }
        
        throw APIError.server(url: request.path, statusCode: 500)
    }
}
