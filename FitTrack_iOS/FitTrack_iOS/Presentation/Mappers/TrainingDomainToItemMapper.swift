//
//  TrainingDomainToItemMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 28/09/25.
//

import Foundation

struct TrainingDomainToItemMapper {
    func map(_ domain: Training, user: User) -> TrainingItem {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        isoFormatter.timeZone = TimeZone(secondsFromGMT: .zero)
        let date = isoFormatter.date(from: domain.scheduledAt ?? "") ?? Date()
        let metric = ["2h", "1h", "45m"].randomElement()!
        let icon = ["figure.soccer", "figure.strengthtraining.traditional", "figure.yoga"].randomElement()!
        
        return .init(
            id: domain.id ?? UUID(),
            date: date,
            metric: metric,
            icon: icon,
            userITem: UserDomainToItemMapper().map(user)
        )
    }
}
