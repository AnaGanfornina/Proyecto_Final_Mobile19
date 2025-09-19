//
//  HomeTabBar.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI

/// MainTabBar with  animated tab bar for switching between the main screens.
struct MainTabBar: View {
    /// Tracks which tab is currently selected (0: Home, 1: Clients, 2: Exercises) Home as Default
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            // Content Area: Shows the currently selected view
            ZStack {
                switch selectedTab {
                case 0:
                    HomeView() // Show Home screen
                case 1:
                    ClientsListView() // Show Clients screen
                case 2:
                    ExcerciseListView() // Show Exercises screen
                default:
                    HomeView() // Fallback to Home
                }
            }
            
            
            
            // Divider for separation above the tab bar
            Divider()
                .background(Color.gray.opacity(0.3))
                .padding(-24) // Used for HomeView Card List to end right above Divider line
            
            // Tab Bar
            HStack {
                // Home Tab Button
                tabButton(icon: "house.fill", text: "Inicio", index: 0)
                Spacer()
                // Clients List Tab Button
                tabButton(icon: "person.3", text: "Clientes", index: 1)
                Spacer()
                // Exercises List Tab Button
                tabButton(icon: "figure.strengthtraining.traditional", text: "Ejercicios", index: 2)
            }
            .padding(.horizontal, 44)
        }
        
    }

    /// Builds aa simple animated tab button for the tab bar.
    /// - Parameters:
    ///   - icon: SF Symbol name for the tab icon
    ///   - text: Tab label
    ///   - index: Tab index matching the selected tab
    @ViewBuilder
    private func tabButton(icon: String, text: String, index: Int) -> some View {
        Button(action: {
            // Animate the transition when switching tabs
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                selectedTab = index
            }
        }) {
            VStack(spacing: 4) {
                // Tab Icon with scale animation if selected
                // We use foreground Style instead of foreGroundColor because we are using a Gradient
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .bold))
                    .scaleEffect(selectedTab == index ? 1.3 : 1.0) // Zoom when selected
                    .foregroundStyle(
                                selectedTab == index
                                ? LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing)
                                : LinearGradient(colors: [.gray, .gray], startPoint: .leading, endPoint: .trailing)
                            ) // Gradient, Both selected and unselected need to be same type (Linear Gradient)
                    .animation(.spring(), value: selectedTab) // Animate icon scaling/color
                // Tab Label
                Text(text)
                    .font(.caption)
                    .foregroundStyle(
                                selectedTab == index
                                ? LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing)
                                : LinearGradient(colors: [.gray, .gray], startPoint: .leading, endPoint: .trailing)
                            ) // Color highlight
            }
        }
    }
}

#Preview {
    MainTabBar()
}
