//
//  OnBoarding.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import SwiftUI

struct OnBoarding: View {
    @Environment(AppState.self) var appState
    
    var body: some View {
        VStack{
            Text("This is OnBoarding")
            Button {
                //metodo del appState para  pasar al login
                appState.performSignUp()
            } label: {
                Text("Iniciar Sesión")
            }
            
        }
        
    }
}

#Preview {
    OnBoarding()
        .environment(AppState())
}
