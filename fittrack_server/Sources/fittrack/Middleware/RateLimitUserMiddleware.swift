//
//  RateLimitUserMiddleware.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 25/9/25.
//

import Vapor

final class RateLimitUserMiddleware: AsyncMiddleware, @unchecked Sendable {
    
    private var requestLog: [String: [Date]] = [:]
    private var maxRequest: Int
    private var window: TimeInterval // seconds
    
    init(maxRequest: Int = 10, window: TimeInterval = 60) {
        self.maxRequest = maxRequest
        self.window = window
    }
    
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        // Intercept request
        let token = try request.auth.require(JWTToken.self)
        let userID = token.userID.value
        let identifier = userID
        let now = Date()
        
        
        let validRequests = (requestLog[identifier] ?? []).filter { $0 > now - window }
        // aplicate rate limit logic
        guard validRequests.count < maxRequest else  {
            throw Abort(.tooManyRequests)
    }
        requestLog[identifier] = validRequests + [now]
    
        return try await next.respond(to: request)
    
    }
}
