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
    var trainingListRecived: [Training]? = nil
    
    func create(name: String, traineeId: UUID, scheduledAt: String) async throws -> Training {
        guard let dataReceived else {
            throw AppError.network("The request could not be understood or was missing required parameters")
        }
        
        return dataReceived
    }
    
    func getAll(filter: String?) async throws -> [Training] {
        guard let trainingListRecived else {
            throw AppError.network("The request could not be understood or was missing required parameters")
        }
        
        guard !trainingListRecived.isEmpty else {
            throw AppError.emptyList()
        }
        
        guard filter != nil else {
            return trainingListRecived
        }
        
        return trainingListRecived.filter {
            $0.scheduledAt == "2025-09-21T14:06:36Z"
        }
    }
    
    func getByMonth(_ month: Int, year: Int) async throws -> [Training] {
        guard let trainingListRecived else {
            throw AppError.network("The request could not be understood or was missing required parameters")
        }
        
        guard !trainingListRecived.isEmpty else {
            throw AppError.emptyList()
        }
        
        guard month == 9 && year == 2025 else {
            return []
        }
        
        return trainingListRecived
    }
    
    func update(training: Training) async throws -> Training {
        guard let dataReceived else {
            throw AppError.network("The request could not be understood or was missing required parameters")
        }
        
        return dataReceived
    }
}
