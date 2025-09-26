//
//  OnBoarding.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import SwiftUI

struct OnBoardingView: View {
    @Environment(AppState.self) var appState
    
    @Binding var isTabBarHidden: Bool 
    
    // MARK: - Animated Onboarding Texts
    @State private var intros: [Intro] = sampleIntros
    @State private var activeIntro: Intro?
    
    var body: some View {
        NavigationStack {

            GeometryReader {
                let size = $0.size
                VStack{
                    
                    if let activeIntro {
                        // Background rectangle with animation color
                        Rectangle()
                            .fill(activeIntro.bgColor)
                            .padding(.bottom,  -32)
                            .overlay {
                                // Animated circle and text
                                Circle()
                                    .fill(activeIntro.circleColor)
                                    .frame(width: 38, height: 38)
                                    .background(alignment: .leading, content: {
                                        Capsule()
                                            .fill(activeIntro.bgColor)
                                            .frame(width: size.width)
                                    })
                                    .background(alignment: .leading) {
                                        Text(activeIntro.text)
                                            .font(.largeTitle)
                                            .foregroundStyle(activeIntro.textColor)
                                            .frame(width: textSize(activeIntro.text))
                                            .offset(x: 10)
                                        // Moving Text based on text Offset
                                            .offset(x: activeIntro.textOffset)
                                    }
                                // Moving Circle in the Opposite Direction (Move to left)
                                    .offset(x: -activeIntro.circleOffset)
                            }
                    }
                    
                    // Onboarding Buttons (login, register, Apple)
                    OnBoardingButtons()
                        .padding(.bottom, 12)
                        .padding(.top, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.black))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 8)
                    
                } // VStack
                .ignoresSafeArea() // Allow background to cover the entire screen
            } // GeometryReader
            .task {
                // Start intro animation sequence once, when view appears.
                if activeIntro == nil {
                    activeIntro = sampleIntros.first
                    // Wait briefly before starting animations
                    let nanoSecond = UInt64(1_000_000_000 * 0.15)
                    try? await Task.sleep(nanoseconds: nanoSecond)
                    animate(0) // Animation
                }
            }
        }
    } // View
    
    /// MARK: - Onboarding Buttons
    /// Provides buttons for Apple sign-in, registration, and login.
    @ViewBuilder
    func OnBoardingButtons() -> some View {
        VStack(spacing: 12) {
            // Apple Sign In Button
            Button {
                // TODO: Apple sign-in action (to be implemented)
            } label: {
                Label("Continuar con Apple", systemImage: "applelogo")
                    .foregroundStyle(.black)
                    .fillButton(.white)
            }
            
            // Register Button
            
            NavigationLink {
                CreateClientView(isTabBarHidden: $isTabBarHidden, registerViewModel: RegisterViewModel())

            } label: {
                //appState.performNewRegister()
                Label("Registrarse", systemImage: "person.badge.plus")
                    .foregroundStyle(.white)
                    .fillButton(.orange1)
            }
            
            // Login Button
            Button {
                appState.performSignUp()
                
            } label: {
                Label("Iniciar Sesión", systemImage: "")
                    .foregroundStyle(.white)
                    .fillButton(.black)
                    .shadow(color: .white, radius: 1.1)
            }
        } // VStack
        .padding(.bottom, 24)
        .padding(16)
    }
    
    // MARK: - Animation Logic
    
    /// Animates the onboarding intro sequence step by step.
    ///
    /// `DispatchQueue.main.asyncAfter` is used here to precisely control
    /// the timing of each animation and avoid SwiftUI overlay/interactivity bugs.
    ///
    /// ### Why use DispatchQueue for animation chaining in SwiftUI?
    /// - SwiftUI's `.withAnimation(completion:)` is not always reliable for predictable sequencing,
    ///   especially when switching views or chaining multiple steps.
    /// - Chaining with `DispatchQueue.main.asyncAfter` ensures each animation and UI update happens
    ///   in the main thread, after the previous animation's visual duration.
    /// - This technique prevents invisible overlays or blocked interactions that can happen
    ///   if SwiftUI's implicit animation system gets out of sync with your model changes.
    ///
    /// - Parameters:
    ///   - index: The current intro index to animate.
    ///   - loop: If true, the sequence repeats from the beginning once all intros are shown.
    
    // Animating Intros
    func animate(_ index: Int, _ loop: Bool = true) {
        if intros.indices.contains(index + 1) {
            // Step 1: Animate offset out
            activeIntro?.text = intros[index].text
            activeIntro?.textColor = intros[index].textColor
            
            // Animating Offsets
            withAnimation(.snappy(duration: 1), completionCriteria: .removed) {
                activeIntro?.textOffset = -(textSize(intros[index].text) + 20)
                activeIntro?.circleOffset = -(textSize(intros[index].text) + 20) / 2
            } completion: {
                // Step 2: After the first animation (1s), animate offset in and color changes
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.snappy(duration: 0.8)) {
                        activeIntro?.textOffset = 0
                        activeIntro?.circleOffset = 0
                        activeIntro?.circleColor = intros[index + 1].circleColor
                        activeIntro?.bgColor = intros[index + 1].bgColor
                    }
                    // Step 3: After the second animation (0.8s), advance to the next intro
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        animate(index + 1, loop)
                    }
                }
                
                
            } // Completion1
        } else {
            // Restart the animation sequence if looping is enabled
            if loop {
                animate(0, loop)
            }
        }
    }
    
    // Fetching text size based on Fonts
    func textSize(_ text: String) -> CGFloat {
        return NSString(string: text).size(
            withAttributes: [
                .font: UIFont.preferredFont(forTextStyle: .largeTitle)]).width
    }
}

#Preview {
    OnBoardingView(isTabBarHidden: .constant(false))
        .environment(AppState())
        .preferredColorScheme(.dark) /// Used for black stroke besides buttons
}

// MARK: - Custom Button Modifier for OnBoarding Buttons
extension View {
    /// Adds a consistent filled style to onboarding buttons.    @ViewBuilder
    func fillButton(_ color: Color) -> some View {
        self
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(color)
            )
    }
}
