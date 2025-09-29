//
//  ExcerciseList.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI
 /*
// TODO: Use Real Models or future Mock Models
struct Exercise: Identifiable {
    let id: UUID
    var exerciseImage: Image? = nil
    var name: String
    var muscleGroup: String  // MuscleGroup
    var category: String     // Training Type: Hypertrophy, Cardio, Machine, Dumbbell, Bodyweight, etc.
}
*/
struct ExerciseCell: View {
    
    var exercise: Exercise
    
    var body: some View {
        HStack {
            // If exercise image exists
            let exerciseImage: Image = {
                if let imageName = exercise.exerciseImage, !imageName.isEmpty {
                    return Image(imageName)
                } else {
                    return Image("exerciseGeneral")
                }
            }()
            
            exerciseImage
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                .shadow(radius: 1)

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
                .foregroundStyle(LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing))
        }
    } // ExerciseCell View
}

struct ExerciseListView: View {
    @Binding var isTabBarHidden: Bool
    @State var exerciseViewmodel: ExercisesViewModel
    
    init(isTabBarHidden: Binding<Bool> = .constant(false), ExerciseViewmodel: ExercisesViewModel = ExercisesViewModel(), searchText: String = "") {
        self._isTabBarHidden = isTabBarHidden
        self.exerciseViewmodel = ExerciseViewmodel
        self.searchText = searchText
    }
    
    // Exercises Mock data
    let mockExercises: [Exercise] = ExercisesViewModel().trainingItemList
    
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
        ? exerciseViewmodel.trainingItemList
        : exerciseViewmodel.trainingItemList.filter {
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
        .onAppear {
            exerciseViewmodel.getAll()
        }
    }
}

#Preview {
    ExerciseListView(isTabBarHidden: .constant(false))
}

