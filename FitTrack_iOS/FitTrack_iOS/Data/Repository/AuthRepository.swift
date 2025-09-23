//
//  AuthRepository.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 7/9/25.
//

import Foundation

protocol AuthRepositoryProtocol {
    func signup(user: User) async throws
    func login(user: String, password: String) async throws
    func getSession() async throws -> String
}

final class AuthRepository: AuthRepositoryProtocol{
    private var apiSession:  APISessionContract
    private var authDataSource: AuthDataSourceProtocol
    
    init(apiSession: APISessionContract = APISession.shared,
         authDatasource: AuthDataSourceProtocol = AuthDataSource.shared) {
        self.apiSession = apiSession
        self.authDataSource = authDatasource
    }
    
    func signup(user: User) async throws {
        let userDTO = UserDomainToDTOMapper().map(user)
        let signupData = try await apiSession.request(
            SignupURLRequest(userDTO: userDTO)
        )
        guard let jwt = signupData.accessToken,
              let userId = signupData.userId else {
            throw AppError.session("Session not found or invalid, log in again")
        }
        // Save userId into UserDefaults to use it to get data related to the main user
        UserDefaults.standard.set(userId, forKey: "userId")
        try await authDataSource.set(jwt)
    }
    
    func login(user: String, password: String) async throws {
        let loginData = try await apiSession.request(
            LoginURLRequest(user: user, password: password)
        )
        guard let jwt = loginData.accessToken,
              let userId = loginData.userId else {
            throw AppError.session("Session not found or invalid, log in again")
        }
        // Save userId into UserDefaults to use it to get data related to the main user
        UserDefaults.standard.set(userId, forKey: "userId")
        try await authDataSource.set(jwt)
    }
    
    func getSession() async throws -> String {
        try await authDataSource.get()
    }
}
