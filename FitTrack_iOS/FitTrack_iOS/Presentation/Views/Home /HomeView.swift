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
                
                // Profile Button
                HStack(spacing: 52) {
                    Button(action: {
                        print("Perfil pulsado")
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.purple2)
                    }
                    .padding(.horizontal)
                    
                    Text("Fit Track")
                        .fontWeight(.bold)
                        .font(.title)
                } // HStack
                .padding()
                
                .navigationDestination(isPresented: $showCreateClient) {
                    CreateClientView()
                }
                .navigationDestination(isPresented: $showNewTraining) {
                    NewTrainingView(selectedClient: $selectedClient)
                }
                
                HStack(spacing: 24) {
                    
                    // Add Client Button
                    Button(action: { showCreateClient = true }) {
                        VStack(spacing: 4) {
                            // Símbolo +
                            Image(systemName: "plus")
                                .font(.system(size: 36, weight: .medium))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.orange1, .red1],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            
                            // Text
                            Text("Crear cliente")
                                .font(.footnote)
                                .foregroundStyle(
                                    Color.gray1
                                )
                        }
                        .frame(minWidth: 110, minHeight: 100)
                        .padding()
                        .overlay(
                            // Gradient Rectangle Around + and "Crear Cliente"
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(
                                        colors: [.orange1, .red1],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                    } // Add Client Button Ends
                    
                    
                    // New Training Button
                    Button(action: { showNewTraining = true }) {
                        VStack(spacing: 4) {
                            // Símbolo +
                            Image(systemName: "pencil.and.list.clipboard")
                                .font(.system(size: 28, weight: .medium))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.orange1, .red1],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            
                            // Text
                            Text("Nuevo \n Entrenamiento")
                                .font(.footnote)
                                .foregroundStyle(
                                    Color.gray1
                                )
                        }
                        .frame(minWidth: 110, minHeight: 100)
                        .padding()
                        .overlay(
                            // Gradient Rectangle Around "Nuevo Entrenamiento"
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(
                                        colors: [.orange1, .red1],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                    } // New Training Button Ends
                    
                } // HStack with Add Client and New Training Buttons Inside
                .padding(.leading, 44)
                
                // Next Trainings and Calendar Icon
                HStack{
                    Text("Próximos entrenamientos")
                        .padding(.horizontal, 32)
                    Spacer()
                    NavigationLink(destination: CalendarView()) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .font(.system(size: 10, weight: .light))
                            .padding(.trailing, 24)
                            .tint(.purple2)
                    }
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                Spacer()
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
        } // NavigationStack
        
        
    }
}

#Preview {
    HomeView()
}
