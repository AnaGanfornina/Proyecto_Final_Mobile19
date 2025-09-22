//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 8/9/25.
//

import Vapor
import JWTKit

/// Payload es el protocolo para indicar todo lo que va a contener el JWTToken

struct JWTToken: JWTPayload, Authenticatable {
    
    var userID: SubjectClaim
    var userName: SubjectClaim
    var expiration: ExpirationClaim
    var isRefresh: BoolClaim
    
    func verify(using algorithm: some JWTAlgorithm) async throws {
        try expiration.verifyNotExpired()
    }
}


extension JWTToken {
    
    static func generateTokens(
        for username: String,
        andID userID: UUID
    ) -> (
        accessToken: JWTToken,
        refreshToken: JWTToken
    ) {
        let now = Date.now
        let tokenExpDate = now.addingTimeInterval(Constants.accessTokenLifeTime)
        let refreshExpDate = now.addingTimeInterval(Constants.refreshTokenLifeTime)
        
        let accessToken = JWTToken(
            userID: SubjectClaim(value: userID.uuidString),
            userName: SubjectClaim(value: username),
            expiration: ExpirationClaim(value: tokenExpDate),
            isRefresh: false
        )
        
        let refreshToken = JWTToken(
            userID: SubjectClaim(value: userID.uuidString),
            userName: SubjectClaim(value: username),
            expiration: ExpirationClaim(value: refreshExpDate),
            isRefresh: true
        )
        
        return (accessToken, refreshToken)
    }
}
