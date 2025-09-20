//
//  UserRepository.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation

protocol TrainingRepositoryProtocol {
    func create(name: String, goalId: UUID) async throws -> Training
}

final class TrainingRepository: TrainingRepositoryProtocol {
    private let apiSession: APISessionContract
    
    init(apiSession: APISessionContract = APISession.shared) {
        self.apiSession = apiSession
    }
    
    func create(name: String, goalId: UUID) async throws -> Training {
        let trainginDTO = try await apiSession.request(
            CreateTrainingURLequest(
                name: name,
                goalId: goalId
            )
        )
        
        return TrainingDTOToDomainMapper().map(trainginDTO)
    }
}
