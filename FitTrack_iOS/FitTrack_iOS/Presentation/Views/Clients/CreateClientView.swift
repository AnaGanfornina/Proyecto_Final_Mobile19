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
    
    // Datos personales
    @State private var nombre = ""
    @State private var apellido = ""
    @State private var altura = ""
    @State private var peso = ""
    @State private var objetivo = ""
    @State private var historia = ""
    
    // Mediciones iniciales
    @State private var circBrazo = ""
    @State private var circAbdomen = ""
    @State private var circMuslo = ""
    @State private var circPecho = ""
    
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
                    
                    Text("Apellido")
                        .modifier(CustomTextStyle())
                    TextField("Hernández", text: $apellido)
                        .modifier(CustomTextFieldStyle())
                    
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
                    
                    
                    
 
                    Spacer()
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
                            
                            // Title Text
                            Button {
                                // TODO: Save the created client action
                                dismiss()
                                isTabBarHidden = false // Show tab bar when going back
                                
                            } label: {
                                Text("OK")
                                    .foregroundColor(.purple)
                                    .font(.title2)
                                    .frame(minWidth: 10)
                            }
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
    }
}

/// A custom modifier for the TextFields
struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.white))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.purple2.opacity(1), lineWidth: 1)
            )
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
        CreateClientView(isTabBarHidden: .constant(false))
    }
}


