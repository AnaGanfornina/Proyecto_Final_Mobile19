//
//  ExcerciseList.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI

// TODO: Use Real Models or future Mock Models
struct Exercise: Identifiable {
    let id: UUID
    var exerciseImage: Image? = nil
    var name: String
    var muscleGroup: String  // MuscleGroup
    var category: String     // Training Type: Hypertrophy, Cardio, Machine, Dumbbell, Bodyweight, etc.
}

struct ExerciseCell: View {
    
    var exercise: Exercise
    
    var body: some View {
        HStack {
            // If exercise image exists
            if let exerciseImage = exercise.exerciseImage {
                exerciseImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    .shadow(radius: 1)
            } else {
                // Default image if Exercise Image doesn't exist
                Image(systemName: "figure.strengthtraining.traditional")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    .shadow(radius: 1)
            }
            
            // Exercise name and muscle group
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.headline)
                Text(exercise.muscleGroup) // Show Muscle Group below Exercise Name
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Chevron symbol to the right
            Image(systemName: "chevron.right")
                .foregroundStyle(.purple2)
        }
    } // ExerciseCell View
}

struct ExerciseListView: View {
    @Binding var isTabBarHidden: Bool
    
    // Exercises Mock data
    let mockExercises: [Exercise] = [
        Exercise(id: UUID(), exerciseImage: Image("squat"), name: "Sentadilla", muscleGroup: "Piernas", category: "Hipertrofia"),
        Exercise(id: UUID(), exerciseImage: Image("bench"), name: "Press de banca", muscleGroup: "Pecho", category: "Mancuerna"),
        Exercise(id: UUID(), exerciseImage: Image("deadlift"), name: "Peso muerto", muscleGroup: "Espalda", category: "PesoCorporal"),
        Exercise(id: UUID(), name: "Curl de bíceps", muscleGroup: "Brazos", category: "Mancuerna"),
        Exercise(id: UUID(), name: "Extensión de tríceps", muscleGroup: "Brazos", category: "Mancuerna"),
        Exercise(id: UUID(), name: "Elevaciones laterales", muscleGroup: "Hombros", category: "Mancuerna"),
        Exercise(id: UUID(), name: "Plancha", muscleGroup: "Abdomen", category: "PesoCorporal"),
        Exercise(id: UUID(), name: "Abdominales", muscleGroup: "Abdomen", category: "PesoCorporal"),
        Exercise(id: UUID(), name: "Aperturas con mancuernas", muscleGroup: "Pecho", category: "Mancuerna"),
        Exercise(id: UUID(), name: "Burpees", muscleGroup: "Cardio", category: "PesoCorporal"),
        Exercise(id: UUID(), name: "Bíceps con barra", muscleGroup: "Brazos", category: "Máquina"),
        Exercise(id: UUID(), name: "Banco lumbar", muscleGroup: "Espalda", category: "Máquina"),
        Exercise(id: UUID(), name: "Balanceo con kettlebell", muscleGroup: "Piernas", category: "Mancuerna"),
        Exercise(id: UUID(), name: "Box jumps", muscleGroup: "Cardio", category: "PesoCorporal"),
        Exercise(id: UUID(), name: "Abducciones de cadera", muscleGroup: "Piernas", category: "Máquina")
    ]
    
    @State private var searchText = ""
    
    /// Filtered and sorted list of exercises based on the search text.
    ///
    /// - If `searchText` is empty, all exercises from `mockExercises` are returned.
    /// - If `searchText` has a value, the list is filtered to include only exercises
    ///   whose `name`, `muscleGroup`, or `category` **begins with** the entered text.
    ///   This is performed using `hasPrefix`, which checks if a string starts with a given prefix.
    ///
    /// The final list is sorted alphabetically:
    /// 1. By `name`.

    var filteredList: [Exercise] {
        let list = searchText.isEmpty
        ? mockExercises
        : mockExercises.filter {
            let lowerSearch = searchText.lowercased()
            return $0.name.lowercased().hasPrefix(lowerSearch) ||
                   $0.muscleGroup.lowercased().hasPrefix(lowerSearch) ||
                   $0.category.lowercased().hasPrefix(lowerSearch)
        }
        return list.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }
    
    /// Dictionary that groups exercises by the initial letter of their `name`.
    ///
    /// - Uses `filteredList` as the source, so only exercises that match the search text are included.
    /// - The key is the first letter of the exercise's `name`. Uppercased by default.
    /// - The value is an array of `Exercise` objects whose `name` starts with that letter.
    var groupedExercises: [String: [Exercise]] {
        Dictionary(grouping: filteredList) { exercise in
            String(exercise.name.prefix(1))
        }
    }
    
    /// Main view of the ExerciseListView.
    ///
    /// Displays a searchable, alphabetically grouped list of exercises.
    /// Each section is labeled by the first letter of the exercise name, and
    /// each row (A, B, C, D) shows an `ExerciseCell` with the exercise's name, category, and image.
    /// Tapping a row can trigger an action (example: show excercise details).
    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedExercises.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)
                        .font(.headline)
                        .foregroundColor(.purple2)
                    ) {
                        ForEach(groupedExercises[key]!) { exercise in
                            ExerciseCell(exercise: exercise)
                                .listRowSeparatorTint(.purple2)
                                .onTapGesture {
                                    // TODO: Implement action when tapping an exercise
                                    // selectedExercise = exercise
                                    // showExerciseDetail = true
                                }
                        }
                    }
                }
            }
            .navigationTitle("Lista de Ejercicios")
            .searchable(text: $searchText, prompt: "Buscar ejercicios")
            .listStyle(.inset)
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    ExerciseListView(isTabBarHidden: .constant(false))
}

