//
//  CreateClientView.swift
//  FitTrack_iOS
//
//  Created by Álvaro Entrena Casas on 13/9/25.
//

import SwiftUI

struct CreateClientView: View {
    // Used to hide Bottom Tab bar if needed
    @Binding var isTabBarHidden: Bool
    @Environment(\.dismiss) private var dismiss // Dismiss View
    @Environment(AppState.self) var appState
    

    private var showAllTextField: Bool {
            appState.status == .home
        }
    
    
    @State var registerViewModel: RegisterViewModel
#if DEBUG
    @State private var nombre = "Andrea"
    @State private var correo = "a@gmail.com"
    @State private var password = "1234567"
   
    @State private var altura = "1"
    @State private var peso = "1"
    @State private var objetivo = "fff"
    @State private var historia = "fdf"
    
    // Mediciones iniciales
    @State private var circBrazo = "1"
    @State private var circAbdomen = "1"
    @State private var circMuslo = "1"
    @State private var circPecho = "1"

#else

    // Datos personales
    @State private var nombre = ""
    @State private var correo = ""
    @State private var password = ""
    @State private var altura = ""
    @State private var peso = ""
    @State private var objetivo = ""
    @State private var historia = ""
    
    // Mediciones iniciales
    @State private var circBrazo = ""
    @State private var circAbdomen = ""
    @State private var circMuslo = ""
    @State private var circPecho = ""
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
                    .modifier(CustomTextFieldStyle())
                    
                    Text("Contraseña")
                        .modifier(CustomTextStyle())
                    TextField("123456", text: $password)
                        .modifier(CustomTextFieldStyle())
                    
                    Group {
                        if showAllTextField { // Show all the textField for a new Trainee
                            
                            Text("Metricas")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            Divider()
                                .background(Color.white)
                            
                            Text("Altura")
                                .foregroundColor(.white)
                                .modifier(CustomTextStyle())
                            TextField("1.70", text: $altura)
                                .modifier(CustomTextFieldStyle())
                            
                            Text("Peso")
                                .modifier(CustomTextStyle())
                            TextField("70 kg", text: $peso)
                                .modifier(CustomTextFieldStyle())
                            
                            Text("Objetivo")
                                .font(.title2)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Divider()
                                .background(Color.white)
                            
                            TextEditor(text: $objetivo)
                                .frame(minHeight: 80) // Min Height
                                .modifier(CustomTextFieldStyle())
                            
                            Text("Historia y Nivel")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Divider()
                                .background(Color.white)
                            
                            TextEditor(text: $historia)
                                .frame(minHeight: 80) // Min Height
                                .modifier(CustomTextFieldStyle())
                            
                            Text("Mediciones Iniciales")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Divider()
                                .background(Color.white)
                            
                            Text("Circunferencia del brazo")
                                .modifier(CustomTextStyle())
                            TextField("35 cm", text: $circBrazo)
                                .modifier(CustomTextFieldStyle())
                            
                            Text("Circunferencia del abdomen")
                                .modifier(CustomTextStyle())
                            TextField("78 cm", text: $circAbdomen)
                                .modifier(CustomTextFieldStyle())
                            
                            Text("Circunferencia del muslo")
                                .modifier(CustomTextStyle())
                            TextField("78 cm", text: $circMuslo)
                                .modifier(CustomTextFieldStyle())
                            
                            Text("Circunferencia del pecho")
                                .modifier(CustomTextStyle())
                            TextField("78 cm", text: $circPecho)
                                .modifier(CustomTextFieldStyle())
                        }
                    }//Group
                    Spacer()
                    Button {
                        let role: Role = appState.status != .home ? .coach : .trainee

                        //PerformLogin or come back
                        switch role {
                        case .coach:
                            
                            //TODO: Pass this logic to VM
                            Task {
                                do {
                                    //wait to make the register
                                    try await registerViewModel.create(name: nombre, email: correo, password: password, role: role)
                                    
                                    // After perform Login
                                   
                                    appState.performLogin(user: correo, password: password)
          
                                } catch {
                                    print("Error creating user:", error)
                                    dismiss()
                                }
                            }
                          
                           
                        case .trainee:
                            do {
                                Task{
                                    try await registerViewModel.create(name: nombre, email: correo, password: password, role: role)
                                }
                            } catch {
                                print("Error creating user:", error)
                            }
                            
                            dismiss()
                            isTabBarHidden = false // Show tab bar when going back
                        }
                    } label: {
                        HStack {
                            if appState.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(1.2)
                            } else {
                                Text("Aceptar")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    stops: [
                                    Gradient.Stop(color: Color(red: 1, green: 0.74, blue: 0.44), location: 0.00),
                                    Gradient.Stop(color: Color(red: 1, green: 0.38, blue: 0.41), location: 1.00),
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(16)
                    }
                    .disabled(appState.isLoading)


                   
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
                                isTabBarHidden = false // Show tab bar when going back
                            } label: {
                                
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.purple)
                            }
                            
                            // Texto junto al chevron
                            Text("Nuevo Cliente")
                                .foregroundColor(.purple3)
                                .fontWeight(.bold)
                                .font(.title2)
                                .frame(minWidth: 150)
                        }
                    } // Toolbar
                }
        } // ScrllView
        .background(
            
            LinearGradient(gradient: Gradient(
                colors: [Color.purple2,Color.purple2.opacity(0.7)]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.bottom) // Fill Full Screen
        )
        //Force light style in navigation bar
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .toolbarColorScheme(.light, for: .navigationBar)
    }
}

/// A custom modifier for the TextFields
struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding()
            .background(Color.white) // Fondo blanco forzado
            .foregroundColor(.black) // Texto negro forzado
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.purple2.opacity(1), lineWidth: 1)
            )
            .colorScheme(.light) // Fuerza esquema claro para el TextEditor
    }
}



/// A custom modifier for the Title Texts of each TextField
struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.body)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
            CreateClientView(isTabBarHidden: .constant(false), registerViewModel: RegisterViewModel())
            //.environment(AppState().mockState()) //Mock to change appState status, to see traineeRegister change a AppState()
        .environment(AppState()) 
        }
}


