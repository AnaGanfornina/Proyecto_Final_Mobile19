//
//  LoaderView.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(AppState.self) var appState
    
    var body: some View {
        VStack {
            
            Text("Esta es la pantalla de login")
            
            Button {
                print("Antes de login: \(appState.status)")
                appState.performLogin()
                print("Después de login: \(appState.status)")
            } label: {
                Text("Login")
            }

        }
        .background(Color.red.opacity(0.2))
        
    }
}

#Preview {
    LoginView()
        .environment(AppState())
}
