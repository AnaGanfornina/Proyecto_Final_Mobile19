//
//  MockGetTrainingsUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 29/09/25.
//

import XCTest
@testable import FitTrack_iOS

final class MockGetTrainingsUseCase: GetTrainingsUseCaseProtocol {
    var getTrainingsCalled: Bool = false
    var dataReceived: [Training]?
    
    func run(filter: String?) async throws -> [Training] {
        getTrainingsCalled = true
        guard let dataReceived else {
            return []
        }
        
        return dataReceived
    }
}
