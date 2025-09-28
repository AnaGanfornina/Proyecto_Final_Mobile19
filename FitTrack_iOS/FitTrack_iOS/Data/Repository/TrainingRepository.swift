//
//  TrainingRepository.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation

protocol TrainingRepositoryProtocol {
    func create(name: String, traineeId: UUID, scheduledAt: String) async throws -> Training
    func getAll(filter: String?) async throws -> [Training]
    func getByMonth(_ month: Int, year: Int) async throws -> [Training]
}

final class TrainingRepository: TrainingRepositoryProtocol {
    private let apiSession: APISessionContract
    
    init(apiSession: APISessionContract = APISession.shared) {
        self.apiSession = apiSession
    }
    
    func create(name: String, traineeId: UUID, scheduledAt: String) async throws -> Training {
        let trainginDTO = try await apiSession.request(
            CreateTrainingURLRequest(
                name: name,
                traineeId: traineeId,
                scheduledAt: scheduledAt
            )
        )
        
        return TrainingDTOToDomainMapper().map(trainginDTO)
    }
    
    func getAll(filter: String?) async throws -> [Training] {
        let trainingDTOList = try await apiSession.request(
            GetTrainingsURLRequest(filter: filter)
        )
        let trainingList = trainingDTOList.map {
            TrainingDTOToDomainMapper().map($0)
        }
        
        return trainingList
    }
    
    func getByMonth(_ month: Int, year: Int) async throws -> [Training] {
        let trainingsDTOList = try await apiSession.request(
            GetTrainingsByMonthURLRequest(month, year: year)
        )
        let trainingList = trainingsDTOList.map {
            TrainingDTOToDomainMapper().map($0)
        }
        
        return trainingList
    }
}
