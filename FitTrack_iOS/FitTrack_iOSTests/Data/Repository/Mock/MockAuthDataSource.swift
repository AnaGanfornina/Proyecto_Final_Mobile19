//
//  MockLoginRepository.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 16/09/25.
//

import Foundation
@testable import FitTrack_iOS

final class MockAuthDataSource: AuthDataSourceProtocol {
    
    func get() async throws -> String {
        guard let jwt = UserDefaults.standard.string(forKey: "jwtDebug") else {
            throw AppError.session("Session not found or expired, log in again")
        }
        return jwt
    }
    
    func set(_ jwt: String) async throws {
        UserDefaults.standard.setValue(jwt, forKey: "jwtDebug")
    }
    
    func clear() async throws {
        UserDefaults.standard.removeObject(forKey: "jwtDebug")
    }
}
