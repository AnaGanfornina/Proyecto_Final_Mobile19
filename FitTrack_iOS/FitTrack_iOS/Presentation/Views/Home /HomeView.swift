//
//  PrincipalView.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedClient: String? = nil
    @State private var showCreateClient = false
    @State private var showNewTraining = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // Boton de perfil arriba a la izquierda
                HStack {
                    Button(action: {
                        print("Perfil pulsado")
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                    }
                } // HStack
                .padding()
                
                .navigationDestination(isPresented: $showCreateClient) {
                    CreateClientView()
                }
                .navigationDestination(isPresented: $showNewTraining) {
                    NewTrainingView(selectedClient: $selectedClient)
                }
            
                HStack(spacing: 16) {
                    Button(action: { showCreateClient = true }) {
                        Text("Crear cliente")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: { showNewTraining = true }){
                        Text("Nuevo entrenamiento")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } // HStack botones
                
                .padding(.horizontal)
                HStack{
                    Text("Próximos entrenamientos")
                    NavigationLink(destination: CalendarView()) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                Spacer()
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }

    }
}

#Preview {
    HomeView()
}
