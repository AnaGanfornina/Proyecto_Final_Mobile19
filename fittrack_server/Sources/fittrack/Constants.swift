//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 8/9/25.
//

import Foundation

struct Constants {
    
    // Lifetime in seconds
    static let accessTokenLifeTime: Double = 60 * 60 * 24 // 24 horas
    static let refreshTokenLifeTime: Double = 60 * 60 * 24 * 7 // 7 days
}
