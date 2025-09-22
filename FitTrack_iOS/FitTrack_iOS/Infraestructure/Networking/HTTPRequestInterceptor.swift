//
//  HTTPRequestInterceptor.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 21/09/25.
//

import Foundation

protocol HTTPRequestInterceptorProtocol {
    /// Implements an interception
    /// - Parameters:
    ///   - request: a mutable object of type `(URLRequest)`
    func intercept(_ request: inout URLRequest) async throws
}

/// Implements an Interceptor to intercept network calls to add a token
final class HTTPRequestInterceptor: HTTPRequestInterceptorProtocol {
    private let authLocalDataSource: AuthDataSourceProtocol
    
    init(authLocalDataSource: AuthDataSourceProtocol = AuthDataSource()) {
        self.authLocalDataSource = authLocalDataSource
    }
    
    func intercept(_ request: inout URLRequest) async throws {
        let jwt = try await authLocalDataSource.get()
        AppLogger.debug("Bearer token created: \(jwt)")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
    }
}
