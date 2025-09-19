//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 19/9/25.
//

import Vapor

struct AdminMiddelware: AsyncMiddleware {
    
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        let token = try request.auth.require(JWTToken.self)
        
        guard let userID = UUID(token.userID.value),
                let user = try await User.find(userID, on: request.db),
              user.role == .coach  else {
            throw Abort(.unauthorized)
        }
        return try await next.respond(to: request)
    }
}
