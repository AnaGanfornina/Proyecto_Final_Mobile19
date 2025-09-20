//
//  TrainingRepository.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation

protocol TrainingRepositoryProtocol {
    func getAll(filter: String?) async throws -> [Training]
    func create(name: String, goalId: UUID) async throws -> Training
}

final class TrainingRepository: TrainingRepositoryProtocol {
    private let apiSession: APISessionContract
    
    init(apiSession: APISessionContract = APISession.shared) {
        self.apiSession = apiSession
    }
    
    func getAll(filter: String?) async throws -> [Training] {
        let trainingDTOList = try await apiSession.request(
            GetTrainingsURLRequest(filter: filter)
        )
        let trainingList = trainingDTOList.map {
            TrainingDTOToDomainMapper().map($0)
        }
        
        guard !trainingList.isEmpty else {
            throw AppError.emptyList()
        }
        
        return trainingList
    }
    
    func create(name: String, goalId: UUID) async throws -> Training {
        let trainginDTO = try await apiSession.request(
            CreateTrainingURLRequest(
                name: name,
                goalId: goalId
            )
        )
        
        return TrainingDTOToDomainMapper().map(trainginDTO)
    }
}
