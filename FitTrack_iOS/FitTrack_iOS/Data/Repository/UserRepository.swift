//
//  UserRepository.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 23/09/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func getTrainees() async throws -> [User]
}

final class UserRepository: UserRepositoryProtocol {
    private let apiSession: APISessionContract
    
    init(apiSession: APISessionContract = APISession.shared) {
        self.apiSession = apiSession
    }
    
    func getTrainees() async throws -> [User] {
        let traineeDTOs = try await apiSession.request(
            GetTraineesURLRequest()
        )
        
        return traineeDTOs.map {
            UserDTOToDomainMapper().map($0)
        }
    }
}
