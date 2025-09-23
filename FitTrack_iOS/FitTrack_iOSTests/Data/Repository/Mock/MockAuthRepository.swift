//
//  MockAuthRepository.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 17/09/25.
//

import Foundation
@testable import FitTrack_iOS

final class MockAuthRepository: AuthRepositoryProtocol {
    var receivedData: Data? = nil
    
    func signup(user: FitTrack_iOS.User) async throws {
        // TODO: Implement mock logic
    }
    
    func login(user: String, password: String) async throws {
        guard receivedData != nil else  {
            throw AppError.session("Failed to save session, try again")
        }
    }
    
    func getSession() async throws -> String {
        guard let receivedData else {
            throw AppError.session("Session not found or expired, log in again")
        }
        return receivedData.base64EncodedString()
    }
}
