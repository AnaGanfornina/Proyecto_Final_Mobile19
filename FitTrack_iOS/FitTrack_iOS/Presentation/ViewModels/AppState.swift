//
//  AppState.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import Foundation

@Observable
final class AppState {
    var status = Status.none
    
    private var loginUsesCase: LoginUseCaseProtocol
    
    // MARK: - Initializer
    init(loginUsesCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUsesCase = loginUsesCase
    }
    
    // MARK: - Functions
    
    
    //TODO: Remover los parámetros por defautl
    func performLogin(user: String = "TestUser", password: String = "TestPassword"){
        
        
        // llamamos al caso de uso de Login
        Task {
            do {
                if try await loginUsesCase.login(user: user, password: password){
                    self.status = .loaded
                }
            } catch {
                print("error on login")
            }
        }
       
    }
    
    func performSignUp(){
        
        self.status = .loading
    }
    
    
    func logOutUser(){
        
        
        self.status = .none
        
    }
    
    
}

