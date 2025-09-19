//
//  Intro.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 17/09/25.
//

import SwiftUI

// MARK: - Intro Model

/// Represents a single onboarding/introduction slide in the app.
/// Each `Intro` contains text, colors, and offsets used for animations in the OnBoardingView.
struct Intro: Identifiable {
    var id: UUID = .init()
    var text: String
    var textColor: Color
    var circleColor: Color
    var bgColor: Color
    var circleOffset: CGFloat = 0
    var textOffset: CGFloat = 0
}

// MARK: - Sample Intro Data

/// Predefined set of sample intros for the OnboardingView
/// These can be used to populate the OnBoardingView with animated texts
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
        textColor: .black,
        circleColor: .black,
        bgColor: .orange1
    ),
    .init(
        text: "Let's Improve",
        textColor: .orange1,
        circleColor: .orange1,
        bgColor: .gray
    ),
    .init(
        text: "Let's Train",
        textColor: .orange1,
        circleColor: .orange1,
        bgColor: .white
    )
]
