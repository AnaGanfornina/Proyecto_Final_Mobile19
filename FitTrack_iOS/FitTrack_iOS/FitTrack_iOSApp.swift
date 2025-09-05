//
//  FitTrack_iOSApp.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 4/9/25.
//

import SwiftUI

@main
struct FitTrack_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(AppState())
        }
    }
}
