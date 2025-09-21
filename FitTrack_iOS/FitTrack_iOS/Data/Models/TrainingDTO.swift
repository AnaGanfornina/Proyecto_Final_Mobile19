//
//  TrainingDTO.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation

struct TrainingDTO: Decodable {
    let id: UUID?
    let name: String?
    let scheduledAt: String?
    let traineeId: UUID?
    
    enum CodingKeys: String, CodingKey {
        case id, name, scheduledAt
        case traineeId = "trainee_id"
    }
}
