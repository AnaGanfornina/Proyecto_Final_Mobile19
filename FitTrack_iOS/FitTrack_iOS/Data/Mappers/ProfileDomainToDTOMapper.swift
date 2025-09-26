//
//  ProfileDomainToDTOMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

struct ProfileDomainToDTOMapper {
    func map(_ domain: Profile, role: Role) -> ProfileDTO {
        switch role {
        case .coach:
                .init(name: domain.name)
        case .trainee:
                .init(name: domain.name,
                      goal: domain.goal,
                      coachId: domain.coachId,
                      age: domain.age,
                      weight: domain.weight,
                      height: domain.height
                )
        }
    }
}
