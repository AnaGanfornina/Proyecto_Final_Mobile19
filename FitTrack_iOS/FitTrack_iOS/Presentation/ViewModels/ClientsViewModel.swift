//
//  ClientsViewModel.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 27/09/25.
//

import Foundation

@Observable
final class ClientsViewModel {
    private let getTraineesUseCase: GetTraineesUseCaseProtocol
    var clients: [UserItem]
    
    init(getTraineesUseCase: GetTraineesUseCaseProtocol = GetTraineesUseCase()) {
        self.getTraineesUseCase = getTraineesUseCase
        self.clients = []
    }
    
    func load() {
        Task {
            do {
                let trainees = try await getTraineesUseCase.run()
                clients = trainees.map {
                    UserDomainToItemMapper().map($0)
                }
            } catch let error as AppError {
                AppLogger.debug(error.reason)
            } catch {
                AppLogger.debug(error.localizedDescription)
            }
        }
    }
}
