//
//  GetTrainingsByMonthUseCase.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 27/09/25.
//

protocol GetTrainingsByMonthUseCaseProtocol {
    func run(month: Int, year: Int) async throws -> [Training]
}

final class GetTrainingsByMonthUseCase: GetTrainingsByMonthUseCaseProtocol {
    private let trainingRepository: TrainingRepositoryProtocol
    
    init(trainingRepository: TrainingRepositoryProtocol = TrainingRepository()) {
        self.trainingRepository = trainingRepository
    }
    
    func run(month: Int, year: Int) async throws -> [Training] {
        try await trainingRepository.getByMonth(month, year: year)
    }
}
