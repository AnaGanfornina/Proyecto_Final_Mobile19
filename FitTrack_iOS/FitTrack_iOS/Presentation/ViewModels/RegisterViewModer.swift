//
//  RegisterViewModer.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 26/9/25.
//

import Foundation
import Combine

enum RegisterViewState: Equatable {
    case none, loading, loaded, error
}

@Observable final class RegisterViewModer {
    /*
    private let createTraineeUseCase: CreateTraineeUseCaseProtocol
     var: RegisterViewState
     
     init(createTraineeUseCase: CreateTraineeUseCaseProtocol = CreateTraineeUseCase()) {
         self.createTraineeUseCase = createTraineeUseCase
         state = .none
     }
     
     func create(name: String, traineeId: UUID, scheduledAt: Date) {
         state = .loading
         
         Task { @MainActor in
             do {
                 let _ = try await createTraineeUseCase.run(
                     name: name,
                    email: email
                     password: password
                 )
                 state = .loaded
             } catch {
                 state = .error
             }
         }
     }
     
     
     
    */
}
