//
//  ActivityWidgetCards.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI
// Activity Cards for Scroll View inside HomeView to see Next Trainings
struct ActivityWidgetCard: View {
    var icon: Image
    var title: String
    var date: Date
    var color: Color
    var primaryMetric: String
    var secondaryMetric: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            HStack(alignment: .center, spacing: 10) {
                icon
                    .font(.system(.title))
                    .foregroundStyle(color)
                    .frame(width: 30, height: 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(.subheadline, weight: .medium))
                        .foregroundStyle(color)
                    
                    HStack(spacing: 8) {
                        Text(primaryMetric)
                        
                        if let secondaryMetric {
                            Rectangle()
                                .frame(width: 1, height: 10)
                                .foregroundStyle(.secondary.opacity(0.3))
                            
                            Text(secondaryMetric)
                        }
                    }
                    .font(.system(.headline, weight: .medium))
                    .foregroundStyle(.primary)
                }
            }
            
            Spacer()
            
            Text(formatDate(date))
                .font(.system(.subheadline, weight: .regular))
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
    }
    
    private func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return date.formatted(.dateTime.hour().minute())
        }
        return date.formatted(.dateTime.month(.abbreviated).day())
    }
}

// MARK: - Previews
#Preview {
    VStack(spacing: 10) {
        ActivityWidgetCard(icon: Image(systemName: "figure.yoga"), title: "Quick yoga with Sarah", date: Date(), color: .blue, primaryMetric: "1h 13m")
        ActivityWidgetCard(icon: Image(systemName: "figure.soccer"), title: "7-a-side at Powerleague", date: Calendar.current.date(byAdding: .day, value: -4, to: .now)!, color: .red, primaryMetric: "1h 34m", secondaryMetric: "489kcal")
        ActivityWidgetCard(icon: Image(systemName: "figure.yoga"), title: "PR Chest workout", date: Calendar.current.date(byAdding: .day, value: -10, to: .now)!, color: .green, primaryMetric: "45m", secondaryMetric: "228lb")
    }
    .padding()
}

