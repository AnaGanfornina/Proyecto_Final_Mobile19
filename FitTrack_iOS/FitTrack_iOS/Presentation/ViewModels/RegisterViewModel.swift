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

@Observable final class RegisterViewModel {
    
    private let registerUserUseCase: SignupUseCaseProtocol
     var state: RegisterViewState
     
     init(registerUserUseCase: SignupUseCaseProtocol = SignupUseCase()) {
         self.registerUserUseCase = registerUserUseCase
         state = .none
     }
     
    func create(name: String, email: String, password: String, role:Role) async throws {
         state = .loading
         let newUser = User (
            email: email,
            password: password,
            role: role,
            profile: Profile(name:name)
         )
        
        do {
            let _ = try await registerUserUseCase.run(user: newUser)
            
            state = .loaded
        } catch {
            state = .error
        }    
    }
 
}
