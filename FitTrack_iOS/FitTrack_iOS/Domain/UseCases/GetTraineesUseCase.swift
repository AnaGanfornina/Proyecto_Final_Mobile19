//
//  GetTraineesUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 23/09/25.
//

protocol GetTraineesUseCaseProtocol {
    func run() async throws -> [User]
}

final class GetTraineesUseCase: GetTraineesUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    func run() async throws -> [User] {
        try await userRepository.getTrainees()
    }
}
