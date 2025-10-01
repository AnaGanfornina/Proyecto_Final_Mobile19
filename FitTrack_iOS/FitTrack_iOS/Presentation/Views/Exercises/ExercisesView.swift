//
//  ExercisesView.swift
//  FitTrack_iOS
//
//  Created by Álvaro Entrena Casas on 13/9/25.
//

import SwiftUI

struct ExercisesView: View {
    
    @State private var exercises = ["Bench press", "Squat", "Deadlift", "Pull-up", "Shoulder Press", "Bicep Curl"]
    @State private var searchText = ""
    
    var body: some View {
       NavigationStack{
            VStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                HStack {
                    Button("Filter by muscle") {
                        print("Filter tapped")
                    }
                    .padding()
                    Button("Any category"){
                        print("Filter tapped")
                    }
                }
                List {
                    ForEach(exercises, id: \.self) { exercise in
                        Text(exercise)
                            .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Exercises")
        }
    }
}

#Preview {
    ExercisesView()
}
