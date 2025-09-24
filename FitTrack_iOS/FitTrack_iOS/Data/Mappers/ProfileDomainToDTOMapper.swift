//
//  ProfileDomainToDTOMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

struct ProfileDomainToDTOMapper {
    func map(_ domain: Profile) -> ProfileDTO {
        if let coachId = domain.coachId {
            .init(name: domain.name,
                  goal: domain.goal,
                  coachId: coachId,
                  age: domain.age,
                  weight: domain.weight,
                  height: domain.height
            )
        } else {
            .init(name: domain.name)
        }
    }
}
