//
//  ActivityWidgetCards.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//


import SwiftUI

struct TrainingDomainToItemMapper {
    func map(_ domain: Training, user: User) -> TrainingItem {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        isoFormatter.timeZone = TimeZone(secondsFromGMT: .zero)
        let date = isoFormatter.date(from: domain.scheduledAt ?? "") ?? Date()
        let metric = ["2h", "1h", "45m"].randomElement()!
        let icon = ["figure.soccer", "figure.strengthtraining.traditional", "figure.yoga"].randomElement()!
        let userImage = ["sarah", "joey_t", "benito_bodoque"].randomElement()!
        
        return .init(
            id: domain.id ?? UUID(),
            date: date,
            metric: metric,
            icon: icon,
            userITem: UserItem(
                id: UUID(uuidString: user.id ?? "") ?? UUID(),
                image: userImage,
                firstName: user.profile.name
            ))
    }
}

struct UserItem: Identifiable {
    let id: UUID
    var image: String
    var firstName: String
}

struct TrainingItem: Identifiable {
    let id: UUID
    let date: Date
    let metric: String
    let icon: String
    let userITem: UserItem
}

// Activity Cards for Scroll View inside HomeView to see Next Trainings
struct ActivityWidgetCard: View {
    var trainingItem: TrainingItem
    
    var body: some View {
        GeometryReader { geo in
            let cardHeight = geo.size.height // Used to know CardHeight all the time
            
            HStack(spacing: 0) {
                // Client Image: fills full card height and is a square
                Image(trainingItem.userITem.image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: cardHeight, height: cardHeight) // Card height used to fill the entire Card Height and width so its a perfect square
                    .clipped()
                    .clipShape(.containerRelative) /// Instead of corner raidus, it adjusts to its container cornerRadius
                
                // Client Name and Date of the Training
                HStack(alignment: .center, spacing: 10) {
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(trainingItem.userITem.firstName)
                            .font(.system(.headline, weight: .semibold))
                        
                        HStack(spacing: 8) {
                            // Date Day Month or Time if its the current day
                            Text(formatDate(trainingItem.date))
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
                    
                    Text(trainingItem.metric) // Principal Metric Duration
                        .font(.subheadline)
                        .padding(.trailing, 4)
                        .frame(width: 48, alignment: .leading)
                }
                
                // Activity icon (Yoga, Gym, Running)
                Image(systemName: trainingItem.icon)
                    .font(.system(.title))
                    .foregroundStyle(.purple2)
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 16)
            }
            .background(.purple1.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
        } // Geometry Reader
        .frame(height: 72) // Set the card height
    }
    
    // Function to return the Date, if it is today, it returns the time + " Hoy"
    private func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return date.formatted(.dateTime.hour().minute()) // If the Date is today, returns Time
        }
        return date.formatted(.dateTime.month(.abbreviated).day())  // If date is not today, returns day - Month
    }
}

// MARK: - Previews
#Preview {
}
