//
//  AuthDataSource.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 17/09/25.
//

import Foundation
import KeychainSwift

protocol AuthDataSourceProtocol {
    func get() async throws -> String
    func set(_ jwt: String) async throws
    func clear() async throws
}

final class AuthDataSource: AuthDataSourceProtocol {
    static let shared = AuthDataSource()
    private let keychain = KeychainSwift()
    
    func get() async throws -> String {
        guard let jwt = keychain.get("jwtData") else {
            AppLogger.debug("Session not found or expired, log in again")
            throw AppError.session("Session not found or expired, log in again")
        }
        return jwt
    }
    
    func set(_ jwt: String) async throws {
        guard keychain.set(jwt, forKey: "jwtData") else {
            AppLogger.debug("Failed to save session, try again")
            throw AppError.session("Failed to save session, try again")
        }
    }
    
    func clear() async throws {
        guard keychain.clear() else {
            AppLogger.debug("Failed to clear session, restart the app")
            throw AppError.session("Failed to clear session, restart the app")
        }
    }
}
