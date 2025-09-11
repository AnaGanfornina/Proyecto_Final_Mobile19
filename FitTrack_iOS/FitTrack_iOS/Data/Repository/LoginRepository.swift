//
//  LoginRepository.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 7/9/25.
//

import Foundation

protocol LoginRepositoryProtocol {
    func loginApp(user: String, pass: String) async throws -> String // return token JWT
}




final class LoginRepository: LoginRepositoryProtocol{
     
    private var network:  ApiProviderProtocol
    
    init(network: ApiProviderProtocol) {
        self.network = network
    }
    
    func loginApp(user: String, pass: String) async throws-> String {
        
        return try await network.login(username: user, password: pass)
    }
    
    
}
// MARK: - LoginRepository Mock

final class LoginRepositoryMock: LoginRepositoryProtocol{
    
    private var network:  ApiProviderProtocol
    
    init(network: ApiProviderProtocol = ApiProviderMock()) {
        self.network = network
    }
    
    
    func loginApp(user: String, pass: String) async throws -> String {
        return try await network.login(username: user, password: pass)
    }
    
}
