//
//  LoaderView.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import SwiftUI
// TODO: Change colors to color sets in Assets, OnBoarding Pull request needed
struct LoginView: View {
    @Environment(AppState.self) var appState
    
    @State private var username = ""
    @State private var password = ""
    @State private var rememberMe = false
    
    var body: some View {
        ZStack {
            // BackGround Gradient
            LinearGradient(gradient: Gradient(
                colors: [Color.orange.opacity(0.5),Color.red.opacity(0.8)]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all) // Fill Full Screen
            VStack(spacing: 180) {
                Spacer()
                
                //Welcome title Text
                Text("Bienvenido")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                
                // User profile icon
                VStack(spacing: 24) {
                    // Username text field
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    
                    // Password Field
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                    
                    // Horizontal container for Toggle "Remember me" and "Forgot Password"
                    HStack {
                        // Toggle "Remember me"
                        Toggle("  Recuérdame", isOn: $rememberMe)
                            .foregroundColor(.white)
                            .underline() // Underlined text
                        
                        Spacer()
                        
                        Button {
                            // TODO: Password reset logic
                        } label: {
                            Text("Olvidé mi contraseña")
                                .foregroundColor(.white)
                                .underline()
                        }
                    } //H Stack
                    .padding(.horizontal, 20)
                    
                    // Login Button
                    Button {
                        appState.performLogin()
                    } label: {
                        Text("Iniciar Sesión")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(15)
                            .padding(.horizontal, 20)
                    }
                    // Bottom Texts to Sign-Up
                    HStack {
                        //Sign-up at the bottom
                        Text("¿No tiene cuenta?")
                            .foregroundColor(.white)
                        Button {
                            // TODO: Sign-Up
                        } label: {
                            Text("Regístrate")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                    .padding(.top, 10)
                }  // 2nd VStack
            } // 1st VStack
            .padding()
        } // ZStack
    }
}

#Preview {
    LoginView()
        .environment(AppState())
}
