//
//  CreateClientView.swift
//  FitTrack_iOS
//
//  Created by Álvaro Entrena Casas on 13/9/25.
//

import SwiftUI

struct CreateClientView: View {
    
    @State private var nombreApellido = ""
    @State private var altura = ""
    @State private var peso = ""
    @State private var objetivo = ""
    @State private var historia = ""
    
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading){
                    Text("Datos personales")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                   Spacer()
                    Group {
                        Section("Nombre y Apellido") {
                            TextField("Nombre Apellido", text: $nombreApellido)
                        }
                        Section("Altura") {
                            TextField("cm", text: $altura)
                        }
                        Section("Peso") {
                            TextField("kg", text: $peso)
                        }
                    }
                    .padding(.horizontal)
                } // VStack
              
                
                VStack(alignment: .leading) {
                    Text("Objetivos")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    Spacer()

                    Group {
                        Section{
                            TextField("Objetivo", text: $objetivo)
                        }
                    }
                    .padding(.horizontal)
                } //VStack
                
                VStack(alignment: .leading) {
                    Text("Historia y nivel")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    Spacer()

                    Group {
                        Section{
                            TextField("Experiencia en el gimnasio", text: $historia)
                        }
                    }
                    .padding(.horizontal)
                } //VStack
                
                VStack(alignment: .leading) {
                    Text("Mediciones iniciales")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    Group {
                        Section("Circunferencia de brazo") {
                            TextField("cm", text: $historia)
                        }
                    }
                    .padding(.horizontal)
                } // ScrollView
            }
        }
    }
}

#Preview {
    CreateClientView()
}
