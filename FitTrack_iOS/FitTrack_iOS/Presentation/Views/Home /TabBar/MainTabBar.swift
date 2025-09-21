//
//  HomeTabBar.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI

/// MainTabBar with animated tab bar for switching between the main screens.
struct MainTabBar: View {
    /// Tracks which tab is currently selected (0: Home, 1: Clients, 2: Exercises) Home as Default
    @State private var selectedTab: Int = 0
    @State private var isTabBarHidden: Bool = false // 👈 Control de visibilidad

    var body: some View {
        VStack(spacing: 0) {
            // Content Area: Shows the currently selected view
            ZStack {
                switch selectedTab {
                case 0:
                    HomeView(isTabBarHidden: $isTabBarHidden)
                case 1:
                    ClientsListView(isTabBarHidden: $isTabBarHidden)
                case 2:
                    ExcerciseListView(isTabBarHidden: $isTabBarHidden)
                default:
                    HomeView(isTabBarHidden: $isTabBarHidden)
                }
            }

            // The bar is only shown if it is not hidden
            if !isTabBarHidden {
                Divider()
                    .background(Color.gray.opacity(0.3))
                    .padding(-24)

                // Tab Bar
                HStack {
                    tabButton(icon: "house.fill", text: "Inicio", index: 0)
                    Spacer()
                    tabButton(icon: "person.3", text: "Clientes", index: 1)
                    Spacer()
                    tabButton(icon: "figure.strengthtraining.traditional", text: "Ejercicios", index: 2)
                }
                .padding(.horizontal, 44)
            }
        }
    }

    /// Builds a simple animated tab button for the tab bar.
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
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .bold))
                    .scaleEffect(selectedTab == index ? 1.3 : 1.0)
                    .foregroundStyle(
                        selectedTab == index
                        ? LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing)
                        : LinearGradient(colors: [.gray, .gray], startPoint: .leading, endPoint: .trailing)
                    )
                    .animation(.spring(), value: selectedTab)

                Text(text)
                    .font(.caption)
                    .foregroundStyle(
                        selectedTab == index
                        ? LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing)
                        : LinearGradient(colors: [.gray, .gray], startPoint: .leading, endPoint: .trailing)
                    )
            }
        }
    }
}

#Preview {
    MainTabBar()
}
