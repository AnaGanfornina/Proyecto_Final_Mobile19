//
//  LoginDTO.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 21/09/25.
//

import Foundation

struct AuthDTO: Decodable {
    let accessToken: String?
    let refreshToken: String?
    let userId: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken, refreshToken
        case userId = "user_id"
    }
}
