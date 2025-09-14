//
//  MainTabView.swift
//  FitTrack_iOS
//
//  Created by Álvaro Entrena Casas on 13/9/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ClientsView(selectedClient: .constant(nil))
                .tabItem {
                    Label("Clients", systemImage: "person.2")
                }
            ExercisesView()
                .tabItem {
                    Label("Exercises", systemImage: "figure.strengthtraining.traditional")
                }
        }
    }
}

#Preview {
    MainTabView()
}
