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
              goalId: dto.goalId,
              date: dto.date)
    }
}
