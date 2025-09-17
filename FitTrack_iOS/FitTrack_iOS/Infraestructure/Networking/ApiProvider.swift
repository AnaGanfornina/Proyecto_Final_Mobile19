//
//  ApiProvider.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 7/9/25.
//

import Foundation

protocol ApiProviderProtocol {
    func login(username: String, password: String) async throws -> String
}

final class ApiProvider: ApiProviderProtocol {
    func login(username: String, password: String) async throws -> String {
        return ""  //TODO: Realizar la función real con el login
    }

}

// MARK: ApiProviderMock

final class ApiProviderMock: ApiProviderProtocol {
    func login(username: String, password: String) async throws -> String {
        // Simulamos delay de 2 segundos
        //try await Task.sleep(nanoseconds: 2_000_000_000)
        return "tokenMock"
    }

}
