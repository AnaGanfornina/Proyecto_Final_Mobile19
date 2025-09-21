//
//  ExcerciseList.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI

struct ExcerciseListView: View {
    // Used to hide Bottom Tab bar if needed
    @Binding var isTabBarHidden: Bool
    var body: some View {
        Text("Exercise List")
    }
}

#Preview {
    ExcerciseListView(isTabBarHidden: .constant(false))
}
