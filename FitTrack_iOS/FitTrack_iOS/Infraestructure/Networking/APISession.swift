//
//  APISession.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 17/09/25.
//

import Foundation

protocol APISessionContract {
    /// A generic function that implements a request using  an URL Session
    /// - Parameters:
    ///   - request: an object of type `(URLRequestComponents)` that represents a request to the server and contains an URL, headers, etc.
    ///   - completion: a clossure of type `(Response)`  that represents the data result and returns either a Decodable  or an Error
    func request<URLRequest: URLRequestComponents>(_ request: URLRequest) async throws -> URLRequest.Response
}

final class APISession: APISessionContract {
    static let shared = APISession()
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request<URLRequest>(_ request: URLRequest) async throws -> URLRequest.Response where URLRequest : URLRequestComponents {
        var urlRequest = try URLRequestBuilder(urlRequestComponents: request).build()
        
        if request.authorized {
            // TODO: Add interceptor for secure endpoints
        }
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        
        guard let statusCode else {
            throw APIError.server(url: request.path, statusCode: statusCode)
        }
        
        switch statusCode {
        case 200..<300:
            if URLRequest.Response.self == Data.self {
                return (data as! URLRequest.Response)
            } else {
                do {
                    let response = try JSONDecoder().decode(URLRequest.Response.self, from: data)
                    return response
                } catch {
                    throw APIError.decoding(url: request.path)
                }
            }
        case 401:
            throw APIError.unauthorized(url: request.path, statusCode: statusCode)
        default:
            throw APIError.server(url: request.path, statusCode: statusCode)
        }
    }
}
