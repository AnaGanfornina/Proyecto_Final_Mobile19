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
    let goalId: UUID?
    let date: Date?
}
