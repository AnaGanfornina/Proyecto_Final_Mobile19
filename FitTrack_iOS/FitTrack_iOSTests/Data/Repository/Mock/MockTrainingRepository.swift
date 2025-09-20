//
//  MockTrainingRepository.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation
@testable import FitTrack_iOS

final class MockTrainingRepository: TrainingRepositoryProtocol {
    var dataReceived: Training? = nil
    
    func getAll(filter: String?) async throws -> [Training] {
        // TODO: Add mock implementation
        return []
    }
    
    func create(name: String, goalId: UUID) async throws -> Training {
        guard let dataReceived else {
            throw AppError.network("The request could not be understood or was missing required parameters")
        }
        
        return dataReceived
    }
}
