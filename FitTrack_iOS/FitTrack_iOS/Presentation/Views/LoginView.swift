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
                appState.performLogin()
            } label: {
                Text("Login")
            }

        }
        
    }
}

#Preview {
    LoginView()
        .environment(AppState())
}
