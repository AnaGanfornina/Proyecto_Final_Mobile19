//
//  TrainingDomainToDTOMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 26/09/25.
//

import Foundation

struct TrainingDomainToDTOMapper {
    func map(_ domain: Training) -> TrainingDTO {
        .init(id: domain.id,
              name: domain.name,
              scheduledAt: domain.scheduledAt,
              traineeId: domain.traineeId)
    }
}
