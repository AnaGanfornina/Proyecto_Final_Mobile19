//
//  LoginDTO.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 21/09/25.
//

import Foundation

struct LoginDTO: Decodable {
    let accessToken: String?
    let refreshToken: String?
}
