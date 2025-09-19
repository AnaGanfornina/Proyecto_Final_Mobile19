//
//  TrainingCardDTOToDomainMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation

struct TrainingCardDTOToDomainMapper {
    func map(_ trainingCardDTO: TrainingCardDTO?) -> TrainingCard {
        .init(userImage: trainingCardDTO?.userName,
              userName: trainingCardDTO?.userName,
              status: trainingCardDTO?.status,
              date: trainingCardDTO?.date,
              goal: trainingCardDTO?.goal,
              duration: trainingCardDTO?.duration,
              exercises: trainingCardDTO?.exercises
        )
    }
}
