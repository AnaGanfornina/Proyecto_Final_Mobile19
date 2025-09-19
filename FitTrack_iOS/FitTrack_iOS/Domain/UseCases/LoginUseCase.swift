//
//  LoginUserCase.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 7/9/25.
//

import Foundation

protocol LoginUseCaseProtocol {
    func login(user: String, password: String)  async throws -> Bool
    func hasValidSession() async -> Bool
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
    
    func hasValidSession() async -> Bool {
        if let token = UserDefaults.standard.string(forKey: "authToken")
        {
            return !token.isEmpty
        }
        return false
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
    
    func hasValidSession() async -> Bool {
        return true
    }
}

