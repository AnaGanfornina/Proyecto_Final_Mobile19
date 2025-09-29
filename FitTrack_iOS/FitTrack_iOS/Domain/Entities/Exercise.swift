//
//  Exercise.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 28/9/25.
//


// TODO: Use Real Models or future Mock Models
struct Exercise: Identifiable, Codable {
    let id: String
    var exerciseImage: String? = nil
    var name: String
    var muscleGroup: String  // MuscleGroup
    var category: String     // Training Type: Hypertrophy, Cardio, Machine, Dumbbell, Bodyweight, etc.
}
