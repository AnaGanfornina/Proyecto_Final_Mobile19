//
//  TraineeDomainToUIMapper.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 27/09/25.
//

import Foundation

struct UserDomainToItemMapper {
    func map(_ domain: User) -> UserItem {
        .init(
            id: UUID(uuidString: domain.id ?? "") ?? UUID(),
            clientImage: ["sarah", "joey_t", "benito_bodoque"].randomElement()!,
            firstName: domain.profile.name,
            lastName: ""
        )
    }
}
