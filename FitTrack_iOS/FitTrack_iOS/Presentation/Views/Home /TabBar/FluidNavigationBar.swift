//
//  FluidNavigationBar.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI
import Foundation

// MARK: - Navigation Tabs Enum
enum FluidNavigationBarDestinations: Int, CaseIterable {
    case home
    case clients
    case exercises

    var title: String {
        switch self {
        case .home: return "Inicio"
        case .clients: return "Clientes"
        case .exercises: return "Ejercicios"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .clients: return "person.crop.circle.fill"
        case .exercises: return "figure.strengthtraining.traditional"
        }
    }
}

struct FluidNavigationBar<Segment: View>: View {
    @Binding var selectedTab: FluidNavigationBarDestinations
    @Namespace private var animation
    @ViewBuilder var segment: () -> Segment
    var body: some View {
        HStack(spacing: 16) {
            ForEach(FluidNavigationBarDestinations.allCases, id: \.rawValue) { tab in
                Button(action: {
                    withAnimation(.snappy(duration: 0.3)) {
                        selectedTab = tab
                    }
                }, label: {
                    VStack(spacing: 6) {
                        Image(systemName: tab.icon)
                            .foregroundStyle(.gray)
                        if selectedTab == tab {
                            Text(tab.title)
                                .textCase(.uppercase)
                                .foregroundStyle(.black.opacity(0.6))
                                .transition(.opacity)
                        }
                    }
                    .font(.system(size: 15, weight: .medium))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .foregroundStyle(selectedTab == tab ? .black : .secondary)
                    .background {
                        if selectedTab == tab {
                            segment()
                                .matchedGeometryEffect(id: "segment_background", in: animation)
                        }
                    }
                })
                .buttonStyle(.plain)
            }
        }
    }
}
