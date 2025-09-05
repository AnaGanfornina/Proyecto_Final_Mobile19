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
    
    func loginApp(user: String, password: String){
        self.status = .loading
        
        // llamamos al caso de uso de Login
        //El dispatch es para falsear el login y se sustiutirá por el caso de uso
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.status = .loaded
        }
        
        
    }
    
    
    func closeSessionUser(){
        
        
        self.status = .none
        
    }
    
    
}
