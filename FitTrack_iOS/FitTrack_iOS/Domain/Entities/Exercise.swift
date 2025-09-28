//
//  Exercise.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 28/9/25.
//

// MARK: - SongResponse
/// Modelo para el JSON con la lista de canciones (1 nivel)
struct exerciseResponse: Codable {
    let exercises: [Exercise]
}


// TODO: Use Real Models or future Mock Models
struct Exercise: Identifiable, Codable {
    let id: String
    var exerciseImage: String? = nil
    var name: String
    var muscleGroup: String  // MuscleGroup
    var category: String     // Training Type: Hypertrophy, Cardio, Machine, Dumbbell, Bodyweight, etc.
}
