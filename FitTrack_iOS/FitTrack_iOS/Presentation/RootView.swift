//
//  RootView.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import SwiftUI

struct RootView: View {
    @Environment(AppState.self) var appState
    
    var body: some View {
        
        switch (appState.status) {
            
        case .none:
            EmptyView()
            
            
        case .onBoarding:
            OnBoardingView(isTabBarHidden: .constant(false))
                //.preferredColorScheme(.dark) /// Used for black stroke besides buttons
            
        case .login:
            LoginView(isTabBarHidden: .constant(false))
            
        case .home, .clients, .exercises:
            MainTabBar()
        }
    }
}

#Preview {
    RootView()
    // TODO: Move login and get session mock to a folder called Mocks in the app target
        .environment(AppState())
}
