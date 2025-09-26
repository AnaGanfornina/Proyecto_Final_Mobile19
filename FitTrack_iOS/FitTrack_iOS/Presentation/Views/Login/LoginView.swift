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
    @Binding var isTabBarHidden: Bool
    
    #if DEBUG
    @State private var username = "a@gmail.com"
    @State private var password = "1234567"
    
    #else
    
    @State private var username = ""
    @State private var password = ""
    #endif
    
    @State private var rememberMe = false
    @State private var showAlert = false
    
    // To check if any text fields have an error
    private var hasFieldError: Bool {
        return appState.inlineError != .none
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // BackGround Gradient
                LinearGradient(gradient: Gradient(
                    colors: [Color.orange.opacity(0.5),Color.red.opacity(0.8)]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all) // Fill Full Screen
                
                VStack(spacing: 140) {
                    //Welcome title Text
                    Text("Bienvenido")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // / User and Password Section
                    VStack(spacing: 24) {
                        
                        VStack (spacing: 16){
                            // Username text field
                            TextField("Username", text: $username)
                                .padding()
                                .background(hasFieldError ? Color.red.opacity(0.3) : Color.white)
                                .background(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .inset(by: 0.5)
                                        .stroke(hasFieldError ? Color.red : Color.clear, lineWidth: 1)
                                )
                                .cornerRadius(16)
                                .textInputAutocapitalization(.never)
                            
                            // Password Field
                            SecureField("Password", text: $password)
                                .padding()
                                .background(hasFieldError ? Color.red.opacity(0.3) : Color.white)
                                .background(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .inset(by: 0.5)
                                        .stroke(hasFieldError ? Color.red : Color.clear, lineWidth: 1)
                                )
                                .cornerRadius(16)
                        }
                        
                        // Error Message
                        
                        if hasFieldError {
                            HStack {
                                Text(appState.inlineError.localizedDescription)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(.white.opacity(0.44))
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .fontWeight(.medium)
                            }
                            .padding(.horizontal, -40) // Compensa el padding del VStack padre
                        }
                        // Remember Me & Forgot Password
                        HStack{
                            
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
                        } //HStack
                        
                        
                        // Login Button
                        Button {
                            appState.performLogin(
                                user: username,
                                password: password
                            )
                            
                            DispatchQueue.main.async {
                                if  appState.fullScreenError != nil {
                                    showAlert = true
                                }
                            }
                        } label: {
                            
                            HStack {
                                if appState.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(1.2)
                                } else {
                                    Text("Iniciar Sesión")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                            
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(16)
                        }
                        
                        .disabled(appState.isLoading)
                        
                        // Bottom Texts to Sign-Up
                        HStack {
                            Text("¿No tiene cuenta?")
                                .foregroundColor(.white)
                            
                            NavigationLink {
                                CreateClientView(isTabBarHidden: $isTabBarHidden, registerViewModel: RegisterViewModel())
                                    
                            } label: {
                                Text("Regístrate")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .underline()
                            }
                        }
                        .padding(.top, 10)
                    }  // 2nd VStack
                    .padding(.horizontal, 20)
                } // 1st VStack
                .padding()
                .onChange(of: appState.fullScreenError, { oldValue, newValue in
                    showAlert = newValue != nil
                })
                .alert("Ocurrió un error", isPresented: $showAlert) {
                    Button("Aceptar", role: .cancel) {
                        appState.fullScreenError = nil
                        showAlert = false
                    }
                } message: {
                    if let errorMessage = appState.fullScreenError {
                        Text(errorMessage)
                    }
                }
            } // ZStack
        }
    }
}
#Preview {
    LoginView(isTabBarHidden: .constant(false))
        .environment(AppState())
}
