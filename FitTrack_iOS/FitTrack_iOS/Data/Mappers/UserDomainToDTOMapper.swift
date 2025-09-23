//
//  UserDomainToDTOMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

struct UserDomainToDTOMapper {
    func map(_ domain: User) -> UserDTO {
        .init(id: nil,
              email: domain.email,
              password: domain.password,
              role: RoleDTO(from: domain.role),
              profile: ProfileDomainToDTOMapper().map(
                domain.profile,
                role: domain.role
              ))
    }
}
