//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 21/9/25.
//

import Vapor

struct ApiKeyMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        guard let environmentApiKey = Environment.process.API_KEY else {
            throw Abort(.internalServerError)
        }
        
        guard let apiKey = request.headers.first(name: "X-API-Key") else {
            throw Abort(.unauthorized, reason: "API KEY header is required")
        }
        
        guard apiKey == environmentApiKey else {
            throw Abort(.unauthorized, reason: "Invalid API KEY")
        }
    
        return try await next.respond(to: request)
    }
}
