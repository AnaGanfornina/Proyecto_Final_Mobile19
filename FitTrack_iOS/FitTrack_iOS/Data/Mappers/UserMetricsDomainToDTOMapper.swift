//
//  UserMetricsDomainToDTOMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

struct UserMetricsDomainToDTOMapper {
    func map(_ domain: UserMetrics?) -> UserMetricsDTO {
        .init(coachId: domain?.coachId ?? "",
              age: domain?.age ?? .zero,
              weight: domain?.weight ?? .zero,
              height: domain?.height ?? .zero
        )
    }
}
