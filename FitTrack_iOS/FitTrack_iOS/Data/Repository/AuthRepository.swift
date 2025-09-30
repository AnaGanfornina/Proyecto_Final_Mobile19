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
        guard let jwt = signupData.accessToken else {
            throw AppError.session("Session not found or invalid, log in again")
        }
        
        guard user.role == .coach else { return }
        try await authDataSource.set(jwt)
    }
    
    func login(user: String, password: String) async throws {
        let loginData = try await apiSession.request(
            LoginURLRequest(user: user, password: password)
        )
        guard let jwt = loginData.accessToken else {
            throw AppError.session("Session not found or invalid, log in again")
        }
        
        try await authDataSource.set(jwt)
    }
    
    func getSession() async throws -> String {
        try await authDataSource.get()
    }
}
