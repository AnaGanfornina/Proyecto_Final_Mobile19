//
//  MockURLProtocol.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 17/09/25.
//

import Foundation

//Intercepts network calls and provides mocked responses, simulates erros and validate requests for unit tests.
final class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    static var error: Error?
    
    // To intercept all network requests
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    // Returns always the same response
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let error = Self.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        guard let handler = Self.requestHandler else {
            fatalError("A request handler or error must be provided")
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
    
    static func httpURLResponse(url: URL, statusCode: Int = 200) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: [
                "Content-Type": "application/json, charset=utf-8",
                "Accept": "application/json"
            ]
        )
    }
}
