//
//  MockGetSessionUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class MockGetSessionUseCase: GetSessionUseCaseProtocol {
    var receivedResponse: Data? = nil
    
    func run() async throws {
        guard let _ = receivedResponse else {
            throw AppError.session("Session not found or expired, log in again")
        }
    }
}
