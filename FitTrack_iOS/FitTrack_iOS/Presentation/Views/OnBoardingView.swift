//
//  OnBoarding.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import SwiftUI

struct OnBoardingView: View {
    @Environment(AppState.self) var appState
    /*
     Text("This is OnBoarding")
     //Login Button
     Button {
         //metodo del appState para  pasar al login
         appState.performSignUp()
     } label: {
         Text("Iniciar Sesión")
     }
     */
    
    //Intro
    @State private var intros: [Intro] = sampleIntros
    @State private var activeIntro: Intro?
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack{
                
                if let activeIntro {
                    
                    Rectangle()
                        .fill(activeIntro.bgColor)
                        .padding(.bottom,  -32)
                    // Circle and Text
                        .overlay {
                            
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
                
                // Onboarding Buttons
                OnBoardingButtons()
                    .padding(.bottom, 12)
                    .padding(.top, 8)
                    .background(.black, in: .rect(
                        topLeadingRadius: 24,
                        topTrailingRadius: 24))
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 8)
                
            } // VStack
            .ignoresSafeArea()
        } // GeometryReader
        .task {
            // Animation with delay to look smoother
            if activeIntro == nil {
                activeIntro = sampleIntros.first
                // Delaying 0.15 seconds and Start animation
                let nanoSecond = UInt64(1_000_000_000 * 0.15)
                try? await Task.sleep(nanoseconds: nanoSecond)
                animate(0) // Animation
            }
        }
    } // View
    
    // OnBoarding Buttons
    @ViewBuilder
    func OnBoardingButtons() -> some View {
        VStack(spacing: 12) {
            // Apple Button
            Button {
                
            } label: {
                Label("Continuar con Apple", systemImage: "applelogo")
                    .foregroundStyle(.black)
                    .fillButton(.white)
            }
            
            // Register
            Button {
                
            } label: {
                Label("Registrarse", systemImage: "")
                    .foregroundStyle(.white)
                    .fillButton(.orange1)
            }
            
            // Login
            Button {
                appState.performSignUp()
            } label: {
                Label("Iniciar Sesión", systemImage: "envelope.fill")
                    .foregroundStyle(.purple2)
                    .fillButton(.white)
            }
        } // VStack
        .padding(15)
    }
    
    // Animating Intros
    func animate(_ index: Int, _ loop: Bool = true) {
        if intros.indices.contains(index + 1) {
            // Updating Text and Text Color
            activeIntro?.text = intros[index].text
            activeIntro?.textColor = intros[index].textColor
            
            // Animating Offsets
            withAnimation(.snappy(duration: 1), completionCriteria: .removed) {
                activeIntro?.textOffset = -(textSize(intros[index].text) + 20)
                activeIntro?.circleOffset = -(textSize(intros[index].text) + 20) / 2
            } completion: {
                // Reseting the Offset with Next Slide Color Change
                withAnimation(
                    .snappy(duration: 0.8),
                    completionCriteria: .logicallyComplete) {
                        activeIntro?.textOffset = 0
                        activeIntro?.circleOffset = 0
                        activeIntro?.circleColor = intros[index + 1].circleColor
                        activeIntro?.bgColor = intros[index + 1].bgColor
                    } completion: {
                        // Going to Next Slide
                        
                        // Simply Recursion
                        animate(index + 1, loop)
                    }
            } // Completion1
        } else {
            // Looping
            
            // If looping Applied, Then Reset the Index to 0
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
    OnBoardingView()
        .environment(AppState())
        .preferredColorScheme(.dark) /// Used for black stroke besides buttons
}

// Custom Modifier for OnBoarding Buttons
extension View {
    @ViewBuilder
    func fillButton(_ color: Color) -> some View {
        self
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(color, in: .rect(cornerRadius: 15))
    }
}
