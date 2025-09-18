//
//  MockLoginUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation
@testable import FitTrack_iOS

// MARK: -  LoginUseCaseMock
final class LoginUseCaseMock: LoginUseCaseProtocol {
    var receivedError: APIError? = nil
    var receivedRegexError: RegexLintError? = nil
    
    func run(user: String, password: String) async throws {
        guard receivedError == nil else {
            if let receivedError {
                throw receivedError
            }
            return
        }
        
        guard receivedRegexError == nil else {
            if let receivedRegexError {
                throw receivedRegexError
            }
            return
        }
    }
}
