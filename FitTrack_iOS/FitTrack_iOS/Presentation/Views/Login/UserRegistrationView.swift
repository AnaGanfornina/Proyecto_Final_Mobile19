//
//  UserRegistrationView.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 26/09/25.
//

import SwiftUI

struct UserRegistrationView: View {
    // MARK: - State Variables for User Input
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    
    // TODO: Add AppState,Fields and BUtton Logic
    var body: some View {
        ZStack {
            // MARK: - Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.purple2.opacity(0.9), Color.purple2.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                Spacer()
                    .frame(height: 10)
                // MARK: - Welcome Title
                Text("Crear Cuenta")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                
                // MARK: - Input Fields
                VStack(spacing: 20) {
                    Spacer()
                        .frame(height: 2)
                    // Username
                    TextField("Nombre de usuario", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .keyboardType(.asciiCapable)
                        .textInputAutocapitalization(.never)
                    
                    // Email
                    TextField("Correo electrónico", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    
                    // Password
                    HStack {
                        if showPassword {
                            TextField("Contraseña", text: $password)
                        } else {
                            SecureField("Contraseña", text: $password)
                        }
                        Button(action: { showPassword.toggle() }) {
                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    
                    // Confirm Password
                    HStack {
                        if showConfirmPassword {
                            TextField("Confirmar contraseña", text: $confirmPassword)
                        } else {
                            SecureField("Confirmar contraseña", text: $confirmPassword)
                        }
                        Button(action: { showConfirmPassword.toggle() }) {
                            Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                } // 1st VStack
                .padding(.horizontal, 20)
                .padding(.top, 2)
                
                // MARK: - Register Button
                Button(action: {
                    // TODO: Add the registration logic here
                }) {
                    Text("Registrarse")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color.orange1, Color.red1],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(16)
                } // Register Button
                .padding(.horizontal, 20)
                .padding(.top, 10)
                Spacer()
            } // VStack
            .padding()
            .padding(.top, 12)
        }// ZStack
    }
}

// MARK: - Preview
#Preview {
    UserRegistrationView()
}

