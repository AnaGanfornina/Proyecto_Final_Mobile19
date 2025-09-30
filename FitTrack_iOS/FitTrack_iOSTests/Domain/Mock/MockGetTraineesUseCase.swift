//
//  MockGetTraineesUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 28/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class MockGetTraineesUseCase: GetTraineesUseCaseProtocol {
    var getTraineesCalled: Bool = false
    var dataReceived: [User]?
    
    func run() async throws -> [User] {
        getTraineesCalled = true
        guard let dataReceived else {
            return []
        }
        
        return dataReceived
    }
}
