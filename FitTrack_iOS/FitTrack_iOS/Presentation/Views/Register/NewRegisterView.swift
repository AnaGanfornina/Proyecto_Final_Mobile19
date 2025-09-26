//
//  NewRegisterView.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 25/9/25.
//

import SwiftUI


struct NewRegisterView: View {
    // Used to hide Bottom Tab bar if needed
    @Environment(\.dismiss) private var dismiss // Dismiss View
    @Environment(AppState.self) var appState
    
    @State var registerViewModel: RegisterViewModel
    
    #if DEBUG
    @State private var nombre = "Juan"
    @State private var correo = "juan@gmail.com"
    @State private var password = "1234567"
    
    #else
    
    // Datos personales
    @State private var nombre = ""
    @State private var correo = ""
    @State private var password = ""
    #endif
    
    var body: some View {
        ScrollView {
                VStack(spacing: 16) {
                    
                    //Group -> We dont use Form because it needs to be customized
                    Text("Datos Personales")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                        .background(Color.white)
                    Text("Nombre")
                        .modifier(CustomTextStyle())
                    TextField("Juan", text: $nombre)
                        .modifier(CustomTextFieldStyle())
                    
                    Text("Correo")
                        .modifier(CustomTextStyle())
                    TextField(text: $correo) {
                        Text(verbatim: "hernandez@gmail.com") //Use vervatim to prevent  placeholder to link
                    }
                        .keyboardType(.emailAddress) // teclado de emails
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .modifier(CustomTextFieldStyle())
                    
                    Text("Contraseña")
                        .modifier(CustomTextStyle())
                    TextField("Seis dígitos", text: $password)
                        .modifier(CustomTextFieldStyle())
                   
                }// VStack
                .padding()
                .navigationBarBackButtonHidden(true) /// Hide `< Back` button
                .toolbar {
                    // Tool Bar at the Top
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack(spacing: 80) {
                            // Chevron to go back Home
                            Button {
                                dismiss()
                                
                            } label: {
                                
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.purple)
                            }
                            
                            // Texto junto al chevron
                            Text("Nuevo Cliente")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .font(.title2)
                                .frame(minWidth: 150)
                            
                            // Title Text
                            Button {
                                // TODO: Save the created client action
                                
                                //Use case to register the new user
                                
                                registerViewModel.create(name: nombre, email: correo, password: password)
                                
                                //perform login
                                
                                appState.performLogin(
                                    user: nombre,
                                    password: password
                                )
                          
                            } label: {
                                Text("OK")
                                    .foregroundColor(.purple)
                                    .font(.title2)
                                    .frame(minWidth: 10)
                            }
                        }
                    } // Toolbar
                }
        } // ScrollView
        .background(
            
            LinearGradient(gradient: Gradient(
                colors: [Color.purple2,Color.purple2.opacity(0.7)]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.bottom) // Fill Full Screen
            
        )//Force light style in navigation bar 
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .toolbarColorScheme(.light, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        NewRegisterView(registerViewModel: RegisterViewModel())
            .environment(AppState())
    }
}


