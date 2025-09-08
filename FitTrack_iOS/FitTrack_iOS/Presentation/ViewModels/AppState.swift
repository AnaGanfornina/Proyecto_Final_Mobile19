//
//  AppState.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import Foundation

@Observable
final class AppState {
    var status = Status.onBoarding // TODO: Cambiar a Status.none cuando sepamos qué hacer con la EmptyView
    
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
                self.status = .loading
                if try await loginUsesCase.login(user: user, password: password){
                    self.status = .home
                }
            } catch {
                print("error on login")
                self.status = .none
            }
        }
       
    }
    
    func performSignUp(){
        
        self.status = .login
    }
    
    
    func logOutUser(){
        
        
        self.status = .none
        
    }
    
    
}

