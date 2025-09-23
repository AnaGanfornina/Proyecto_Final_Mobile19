//
//  UserDomainToDTOMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

struct UserDomainToDTOMapper {
    func map(_ domain: User) -> UserDTO {
        switch domain.role {
        case .coach:
            return .init(name: domain.name,
                         email: domain.email,
                         password: domain.password,
                         role: UserRoleDTO(from: domain.role),
                         metrics: nil)
        case .trainee:
            return .init(name: domain.name,
                         email: domain.email,
                         password: domain.password,
                         role: UserRoleDTO(from: domain.role),
                         metrics: UserMetricsDomainToDTOMapper().map(domain.metrics))
        }
    }
}
