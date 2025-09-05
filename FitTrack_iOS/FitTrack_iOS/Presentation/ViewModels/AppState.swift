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
    
    // MARK: - Functions
    
    
    
    func performLogin(user: String = "TestUser", password: String = "TestPassword"){
        
        
        // llamamos al caso de uso de Login
        //El dispatch es para falsear el login y se sustiutirá por el caso de uso
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.status = .loaded
        }
    }
    
    func performSignUp(){
        
        self.status = .loading
    }
    
    
    func logOutUser(){
        
        
        self.status = .none
        
    }
    
    
}
