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
    
    private var usesCase: LoginUseCaseProtocol
    
    // MARK: - Initializer
    init(usesCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.usesCase = usesCase
    }
    
    // MARK: - Functions
    
    
    
    func performLogin(user: String = "TestUser", password: String = "TestPassword"){
        
        
        // llamamos al caso de uso de Login
        Task {
            do {
                if try await usesCase.login(user: user, password: password){
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
// Esto es una prueba para luis en github
