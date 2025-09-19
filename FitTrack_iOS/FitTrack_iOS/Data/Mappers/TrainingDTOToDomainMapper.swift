//
//  TrainingDTOToDomain.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation

struct TrainingDTOToDomainMapper {
    func map(_ trainingDTO: TrainingDTO?) -> Training {
        .init(id: trainingDTO?.id,
              name: trainingDTO?.name,
              goalId: trainingDTO?.goalId,
              date: trainingDTO?.date,
              card: TrainingCardDTOToDomainMapper().map(trainingDTO?.card)
        )
    }
}
