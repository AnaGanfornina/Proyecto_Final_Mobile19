//
//  Intro.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 17/09/25.
//

import SwiftUI

// Intro Model
struct Intro: Identifiable {
    var id: UUID = .init()
    var text: String
    var textColor: Color
    var circleColor: Color
    var bgColor: Color
    var circleOffset: CGFloat = 0
    var textOffset: CGFloat = 0
}

// Sample Intros
var sampleIntros:  [Intro] = [
    .init(
        text: "Let's Coach",
        textColor: .black,
        circleColor: .black,
        bgColor: .purple1
    ),
    .init(
        text: "Let's Track",
        textColor: .white,
        circleColor: .white,
        bgColor: .purple2
    ),
    .init(
        text: "Let's Achieve",
        textColor: .purple2,
        circleColor: .purple2,
        bgColor: .orange1
    ),
    .init(
        text: "Let's Improve",
        textColor: .orange1,
        circleColor: .orange1,
        bgColor: .black
    ),
    .init(
        text: "Let's Train",
        textColor: .orange1,
        circleColor: .orange1,
        bgColor: .white
    )
]
