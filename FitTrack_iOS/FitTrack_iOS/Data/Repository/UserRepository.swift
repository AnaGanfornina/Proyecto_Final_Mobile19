//
//  UserRepository.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func getTrainings() async throws -> [Training]
}

final class UserRepository: UserRepositoryProtocol {
    private let apiSession: APISessionContract
    
    init(apiSession: APISessionContract = APISession.shared) {
        self.apiSession = apiSession
    }
    
    func getTrainings() async throws -> [Training] {
        let trainingDTOList = try await apiSession.request(
            GetTrainingsURLRequest()
        )
        let trainingList = trainingDTOList.map {
            TrainingDTOToDomainMapper().map($0)
        }
        
        guard !trainingList.isEmpty else {
            throw AppError.emptyList()
        }
        
        return trainingList
    }
}
