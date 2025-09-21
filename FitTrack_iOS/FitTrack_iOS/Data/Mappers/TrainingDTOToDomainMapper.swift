//
//  TrainingDTOToDomainMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation

struct TrainingDTOToDomainMapper {
    func map(_ dto: TrainingDTO) -> Training {
        .init(id: dto.id,
              name: dto.name,
              date: dto.date,
              traineeId: dto.coachId)
    }
}
