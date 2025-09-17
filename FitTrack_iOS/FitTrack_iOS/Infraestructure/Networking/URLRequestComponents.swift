//
//  URLRequestComponents.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 17/09/25.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST
}

protocol URLRequestComponents {
    // For Url Components
    var host: String { get }
    var path: String { get }
    var queryParameters: [String:String]? { get }
    
    // For Url Request
    var httpMethod: HTTPMethod { get }
    var headers: [String:String] { get }
    var body: Encodable? { get }
    var authorized: Bool { get }
    
    // For HTTP Response
    associatedtype Response: Decodable
}

// MARK: - Default values for HTTP Request Components
extension URLRequestComponents {
    // TODO: Replace the IP by tour local
    var host: String { "127.0.0.1:8080" }
    var queryParameters: [String:String]? { [:] }
    var headers: [String:String] { [:] }
    var body: Encodable? { nil }
}
