//
//  FitTrack_iOSApp.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 4/9/25.
//

import SwiftUI

@main
struct FitTrack_iOSApp: App {
    
    @StateObject private var appState: AppState
    
    init() {
        let auth = LoginUseCase()
        _appState = StateObject (wrappedValue: AppState(loginUsesCase: auth))
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
        }
    }
}
