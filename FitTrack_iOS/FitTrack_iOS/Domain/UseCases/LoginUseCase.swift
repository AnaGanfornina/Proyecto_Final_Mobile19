//
//  LoginUserCase.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 7/9/25.
//

import Foundation

protocol LoginUseCaseProtocol {
    func login(user: String, password: String)  async throws -> Bool
}

final class LoginUseCase: LoginUseCaseProtocol {
    
    var repository: any LoginRepositoryProtocol
    
    
    init(repository: any LoginRepositoryProtocol = LoginRepository(network: ApiProvider())) {
        self.repository = repository
    }
    
    
    func login(user: String, password: String) async throws -> Bool {
        
        
        let token = try await repository.loginApp(user: user, pass: password)
        return token != ""
    }
}

// MARK: -  LoginUseCaseMock
final class LoginUseCaseMock: LoginUseCaseProtocol {
    
    var repository: any LoginRepositoryProtocol
    
    
    init(repository: any LoginRepositoryProtocol = LoginRepository(network: ApiProviderMock())) {
        self.repository = repository
    }
    
    
    func login(user: String, password: String) async throws -> Bool {
        let token = try await repository.loginApp(user: user, pass: password)
        return token == "tokenMock"
    }
    
    
    
    
    
}

