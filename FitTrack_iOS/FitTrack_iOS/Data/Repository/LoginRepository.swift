//
//  LoginRepository.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 7/9/25.
//

import Foundation

protocol LoginRepositoryProtocol {
    func login(user: String, password: String) async throws
    func getSession() async throws -> String
    func clearSession() async throws
}

final class LoginRepository: LoginRepositoryProtocol{
    private var apiSession:  APISessionContract
    private var authDataSource: AuthDataSourceProtocol
    
    init(apiSession: APISessionContract = APISession.shared,
         authDatasource: AuthDataSourceProtocol = AuthDataSource.shared) {
        self.apiSession = apiSession
        self.authDataSource = authDatasource
    }
    
    func login(user: String, password: String) async throws {
        let jwtData = try await apiSession.request(
            LoginURLRequest(user: user, password: password)
        )
        try await authDataSource.set(jwtData)
    }
    
    func getSession() async throws -> String {
        try await authDataSource.get()
    }
    
    func clearSession() async throws {
        try await authDataSource.clear()
    }
}
