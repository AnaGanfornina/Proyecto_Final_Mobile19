//
//  TrainingDTO.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation

struct TrainingDTO: Decodable {
    let id: UUID?
    let name: String?
    let goalId: UUID?
    let date: Date?
    let card: TrainingCardDTO?
}

enum TrainingStatus: Decodable {
    case next, complete, cancel
}

struct TrainingCardDTO: Decodable {
    let userImage: String?
    let userName: String?
    let status: TrainingStatus?
    let date: Date?
    let goal: String?
    let duration: String?
    let exercises: String?
}
