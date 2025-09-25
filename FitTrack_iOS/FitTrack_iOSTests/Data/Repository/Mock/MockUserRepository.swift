//
//  MockUserRepository.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 24/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class MockUserRepository: UserRepositoryProtocol {
    var getTraineesCalled: Bool = false
    var receivedUsers: [User]?
    
    func getTrainees() async throws -> [User] {
        getTraineesCalled = true
        
        guard let receivedUsers else {
            throw APIError.unknown(url: "/api/users/trainees")
        }
        
        return receivedUsers
    }
}
