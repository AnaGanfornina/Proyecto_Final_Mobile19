//
//  ActivityWidgetCards.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//


import SwiftUI

// Activity Cards for Scroll View inside HomeView to see Next Trainings
struct ActivityWidgetCard: View {
    var clientImage: Image? = nil
    var clientName: String
    var date: Date // Training Date / aPPOINTMENT date
    var color: Color // For Name and Symbol
    var primaryMetric: String // Duration for the Appointment to be completed
    var secondaryMetric: String? // If needed
    var activityIcon: Image // Activity Icon (Lifting Weights, Running, Yoga etc.)
    
    var body: some View {
        GeometryReader { geo in
            let cardHeight = geo.size.height // Used to know CardHeight all the time
            
            HStack(spacing: 0) {
                // Client Image: fills full card height and is a square
                if let clientImage {
                    clientImage
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: cardHeight, height: cardHeight) // Card height used to fill the entire Card Height and width so its a perfect square
                        .clipped()
                        .clipShape(.containerRelative) /// Instead of corner raidus, it adjusts to its container cornerRadius
                }
                
                // Client Name and Date of the Training
                HStack(alignment: .center, spacing: 10) {
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(clientName)
                            .font(.system(.headline, weight: .semibold))
                            .foregroundStyle(color)
                        
                        HStack(spacing: 8) {
                            // Date Day Month or Time if its the current day
                            Text(formatDate(date))
                                .font(.system(.subheadline, weight: .semibold))
                                .foregroundStyle(.primary)
                                .padding(.trailing, 8)
                        }
                        .font(.system(.headline, weight: .medium))
                        .foregroundStyle(.primary)
                    }
                }
                .padding(.leading, 12)
                
                Spacer()
                // Hour and Time
                HStack(spacing: 2) {
                    Image(systemName: "timer")
                        .foregroundColor(.purple2)
                        .font(.system(size: 28))
                        .frame(width: 28, alignment: .trailing)
                    
                    
                    Text(primaryMetric) // Principal Metric Duration
                        .font(.subheadline)
                        .padding(.trailing, 4)
                        .frame(width: 48, alignment: .leading)
                }
                
                // Activity icon (Yoga, Gym, Running)
                activityIcon
                    .font(.system(.title))
                    .foregroundStyle(color)
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 16)
            }
            .background(.purple1.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
        } // Geometry Reader
        .frame(height: 72) // Set the card height
        .padding(.horizontal, 2)
        .padding(.vertical, 4)
    }
    
    // Function to return the Date, if it is today, it returns the time + " Hoy"
    private func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return (date.formatted(.dateTime.hour().minute()) + " Hoy" ) // If the Date is today, returns Time
        }
        return date.formatted(.dateTime.month(.abbreviated).day())  // If date is not today, returns day - Month
    }
}

// MARK: - Previews
#Preview {
    VStack(spacing: 10) {
        ActivityWidgetCard(clientImage: Image("benito_bodoque"), clientName: "Sarah Park", date: Date(), color: .blue, primaryMetric: "2h", activityIcon: Image(systemName: "figure.yoga"))
        
        ActivityWidgetCard(clientImage: Image("benito_bodoque"), clientName: "Benito Bodoque", date: Calendar.current.date(byAdding: .day, value: -4, to: .now)!, color: .red, primaryMetric: "1h", secondaryMetric: "489kcal", activityIcon: Image(systemName: "figure.strengthtraining.traditional"))
        
        ActivityWidgetCard(clientImage: Image("benito_bodoque"), clientName: "Joseph Tribbiani", date: Calendar.current.date(byAdding: .day, value: -10, to: .now)!, color: .green, primaryMetric: "45m", secondaryMetric: "228lb", activityIcon: Image(systemName: "figure.soccer"))
    }
    .padding()
}


