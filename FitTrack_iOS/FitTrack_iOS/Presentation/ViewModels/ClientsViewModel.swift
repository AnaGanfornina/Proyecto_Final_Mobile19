//
//  ClientsViewModel.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 27/09/25.
//

import Foundation

enum ClientsState {
    case none, loading, loaded, error
}

protocol ClientsViewModelProtocol {
    var onStateChanged: ((ClientsState) -> Void)? { get set } // Testing propuse
    var clients: [UserItem] { get }
    func load()
}

@Observable
final class ClientsViewModel: ClientsViewModelProtocol {
    private let getTraineesUseCase: GetTraineesUseCaseProtocol
    var state: ClientsState = .none {
        didSet { onStateChanged?(state) }
    }
    var onStateChanged: ((ClientsState) -> Void)?
    var clients: [UserItem]
    
    init(getTraineesUseCase: GetTraineesUseCaseProtocol = GetTraineesUseCase()) {
        self.getTraineesUseCase = getTraineesUseCase
        self.state = .none
        self.clients = []
    }
    
    func load() {
        state = .loading
        Task { @MainActor in
            do {
                let trainees = try await getTraineesUseCase.run()
                clients = trainees.map {
                    UserDomainToItemMapper().map($0)
                }
                state = .loaded
            } catch {
                state = .error
            }
        }
    }
}
