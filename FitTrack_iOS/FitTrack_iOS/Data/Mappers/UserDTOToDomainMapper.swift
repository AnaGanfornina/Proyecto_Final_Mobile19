//
//  UserDTOToDomainMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 23/09/25.
//

import Foundation

struct UserDTOToDomainMapper {
    func map(_ dto: UserDTO) -> User {
        .init(id: dto.id,
              email: dto.email,
              password: dto.password,
              role: Role(from: dto.role),
              profile: ProfileDTOToDomainMapper().map(dto.profile))
    }
}
