//
//  HomeTabBar.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI


struct HomeTabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }
            ClientsListView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Clientes")
                }
            ExcerciseListView()
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("Ejercicios")
                }
        }
        .accentColor(.purple2) // Optional: sets the selected color if you have .purple2 defined
    }
}

#Preview {
    HomeTabBar()
}
