//
//  URLRequestBuilder.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 17/09/25.
//

import Foundation

final class URLRequestBuilder {
    private let urlRequestComponents: any URLRequestComponents
    
    init(urlRequestComponents: any URLRequestComponents) {
        self.urlRequestComponents = urlRequestComponents
    }
    
    private func url() throws -> URL {
        var urlComponents: URLComponents = URLComponents()
        // TODO: Remplazar por htttps cuando el servidor sea remoto
        urlComponents.scheme = "http"
        urlComponents.host = urlRequestComponents.host
        // TODO: Remover el puerto cuando el servidor sea remoto
        urlComponents.port = 8080
        urlComponents.path = urlRequestComponents.path
        
        if let queryParameters = urlRequestComponents.queryParameters, !queryParameters.isEmpty {
            urlComponents.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        guard let url = urlComponents.url else {
            AppLogger.debug("Failed to create an URL")
            throw APIError.malformedURL(url: urlRequestComponents.path)
        }
        
        return url
    }
    
    func build() throws -> URLRequest {
        do {
            var urlRequest = try URLRequest(url: url())
            urlRequest.httpMethod = urlRequestComponents.httpMethod.rawValue
            urlRequest.allHTTPHeaderFields = [
                "Content-Type": "application/json; charset=utf-8",
                "Accept": "application/json"
            ].merging(urlRequestComponents.headers) { $1 }
            
            if let body = urlRequestComponents.body {
                do {
                    urlRequest.httpBody = try JSONEncoder().encode(body)
                    if let httpBody = urlRequest.httpBody,
                       let jsonString = String(data: httpBody, encoding: .utf8) {
                        AppLogger.debug("HTTP Body created: \(jsonString)")
                    }
                } catch {
                    AppLogger.debug(error.localizedDescription)
                    throw APIError.decoding(url: urlRequestComponents.path)
                }
            }
            
            return urlRequest
        } catch {
            AppLogger.debug("Failed to create an URL request")
            throw APIError.badRequest(url: urlRequestComponents.path, statusCode: 400)
        }
    }
}
