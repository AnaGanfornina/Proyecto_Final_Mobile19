//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 8/9/25.
//

import Vapor

struct JWTTokenDTO: Content {
    
    let accessToken: String
    let refreshToken: String
}
