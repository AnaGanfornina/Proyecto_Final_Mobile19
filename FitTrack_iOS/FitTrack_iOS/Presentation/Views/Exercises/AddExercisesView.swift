//
//  AddExercisesView.swift
//  FitTrack_iOS
//
//  Created by Álvaro Entrena Casas on 14/9/25.
//

import SwiftUI

struct AddExercisesView: View {
    
    @State private var selectedExercises = ["Bench press", "Squat", "Deadlift", "Pull-up", "Shoulder Press", "Bicep Curl"]
    
    @State private var exerciseData: [String: [String: String]] = [:]
    
    
    var body: some View {
        List {
            ForEach(selectedExercises, id: \.self) { exercise in
                VStack(alignment: .leading, spacing: 10) {
                    Text(exercise)
                        .font(.headline)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Series")
                            TextField("0", text: Binding(
                                get: {exerciseData[exercise]? ["series"] ?? ""},
                                set: { newValue in
                                    var data = exerciseData[exercise] ?? [:]
                                    data["series"] = newValue
                                    exerciseData[exercise] = data
                                }
                            ))
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 50)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Peso")
                            TextField("0", text: Binding(
                                get: {exerciseData[exercise]? ["peso"] ?? ""},
                                set: { newValue in
                                    var data = exerciseData[exercise] ?? [:]
                                    data["peso"] = newValue
                                    exerciseData[exercise] = data
                                }
                            ))
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 50)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Reps")
                            TextField("0", text: Binding(
                                get: {exerciseData[exercise]? ["reps"] ?? ""},
                                set: { newValue in
                                    var data = exerciseData[exercise] ?? [:]
                                    data["reps"] = newValue
                                    exerciseData[exercise] = data
                                }
                            ))
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 50)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tiempo")
                            TextField("0", text: Binding(
                                get: {exerciseData[exercise]? ["tiempo"] ?? ""},
                                set: { newValue in
                                    var data = exerciseData[exercise] ?? [:]
                                    data["tiempo"] = newValue
                                    exerciseData[exercise] = data
                                }
                            ))
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 50)
                        }
                    } // HStack
                } // VStack
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            } // ForEach
            .onDelete { indices in
                for index in indices {
                    let exercise = selectedExercises[index]
                    selectedExercises.remove(at: index)
                    exerciseData.removeValue(forKey: exercise)
                }
            }
        } // List
        .listStyle(PlainListStyle())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: ExercisesView()) {
                    Text("Añadir ejercicios")
                }
            }
        }
    }
}
    
    #Preview {
        AddExercisesView()
    }
