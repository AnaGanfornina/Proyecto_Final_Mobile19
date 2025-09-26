//
//  ProfileDTOToDomainMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 23/09/25.
//

import Foundation

struct ProfileDTOToDomainMapper {
    func map(_ dto: ProfileDTO) -> Profile {
        .init(name: dto.name,
              goal: dto.goal,
              coachId: dto.coachId,
              age: dto.age,
              weight: dto.weight,
              height: dto.height)
    }
}
