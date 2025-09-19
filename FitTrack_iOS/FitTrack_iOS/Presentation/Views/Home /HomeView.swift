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
            VStack(alignment: .leading, spacing: 16) {
                
                // MARK: - Top Profile HStack
                HStack(spacing: 16) {
                    Button(action: {
                        print("Perfil pulsado")
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.purple2)
                    }
                    
                    Text("Fit Track")
                        .font(.title.bold())
                }
                .padding(.horizontal)
                
                // Divider debajo del perfil
                Divider()
                    .background(Color.gray.opacity(0.3))
                    .padding(.horizontal)
                
                // MARK: - Navigation Destinations
                .navigationDestination(isPresented: $showCreateClient) {
                    CreateClientView()
                }
                .navigationDestination(isPresented: $showNewTraining) {
                    NewTrainingView(selectedClient: $selectedClient)
                }
                
                // MARK: - Action Buttons (Crear Cliente / Nuevo Entrenamiento)
                HStack(spacing: 16) {
                    
                    // Crear Cliente
                    Button(action: { showCreateClient = true }) {
                        VStack(spacing: 8) {
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .medium))
                                .foregroundStyle(
                                    LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing)
                                )
                            Text("Crear cliente")
                                .font(.footnote)
                                .foregroundStyle(Color.gray1)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing),
                                    lineWidth: 2
                                )
                        )
                    }
                    
                    // Nuevo Entrenamiento
                    Button(action: { showNewTraining = true }) {
                        VStack(spacing: 8) {
                            Image(systemName: "pencil.and.list.clipboard")
                                .font(.system(size: 28, weight: .medium))
                                .foregroundStyle(
                                    LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing)
                                )
                            Text("Nuevo\nEntrenamiento")
                                .font(.footnote)
                                .foregroundStyle(Color.gray1)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing),
                                    lineWidth: 2
                                )
                        )
                    }
                }
                .padding(.horizontal)
                
                // MARK: - Próximos Entrenamientos
                HStack {
                    Text("Próximos entrenamientos")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    Spacer()
                    NavigationLink(destination: CalendarView()) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .tint(.purple2)
                            .padding(.trailing, 20)
                    }
                }
                .padding(.top, 8)
                
                // MARK: - Activity Cards Scroll
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12) {
                        ActivityWidgetCard(
                            clientImage: Image("sarah"),
                            clientName: "Sarah Park",
                            date: Date(),
                            color: .blue,
                            primaryMetric: "2h",
                            activityIcon: Image(systemName: "figure.yoga")
                        )

                        ActivityWidgetCard(
                            clientImage: Image("benito_bodoque"),
                            clientName: "Benito Bodoque",
                            date: Calendar.current.date(byAdding: .day, value: -4, to: .now)!,
                            color: .red,
                            primaryMetric: "1h",
                            secondaryMetric: "489kcal",
                            activityIcon: Image(systemName: "figure.strengthtraining.traditional")
                        )

                        ActivityWidgetCard(
                            clientImage: Image("joey_t"),
                            clientName: "Joseph Tribbiani",
                            date: Calendar.current.date(byAdding: .day, value: -10, to: .now)!,
                            color: .green,
                            primaryMetric: "45m",
                            secondaryMetric: "228lb",
                            activityIcon: Image(systemName: "figure.soccer")
                        )
                        
                        ActivityWidgetCard(
                            clientImage: Image("sarah"),
                            clientName: "Sarah Park",
                            date: Date(),
                            color: .blue,
                            primaryMetric: "2h",
                            activityIcon: Image(systemName: "figure.yoga")
                        )

                        ActivityWidgetCard(
                            clientImage: Image("benito_bodoque"),
                            clientName: "Benito Bodoque",
                            date: Calendar.current.date(byAdding: .day, value: -4, to: .now)!,
                            color: .red,
                            primaryMetric: "1h",
                            secondaryMetric: "489kcal",
                            activityIcon: Image(systemName: "figure.strengthtraining.traditional")
                        )

                        ActivityWidgetCard(
                            clientImage: Image("joey_t"),
                            clientName: "Joseph Tribbiani",
                            date: Calendar.current.date(byAdding: .day, value: -10, to: .now)!,
                            color: .green,
                            primaryMetric: "45m",
                            secondaryMetric: "228lb",
                            activityIcon: Image(systemName: "figure.soccer")
                        )
                        
                        ActivityWidgetCard(
                            clientImage: Image("sarah"),
                            clientName: "Sarah Park",
                            date: Date(),
                            color: .blue,
                            primaryMetric: "2h",
                            activityIcon: Image(systemName: "figure.yoga")
                        )

                        ActivityWidgetCard(
                            clientImage: Image("benito_bodoque"),
                            clientName: "Benito Bodoque",
                            date: Calendar.current.date(byAdding: .day, value: -4, to: .now)!,
                            color: .red,
                            primaryMetric: "1h",
                            secondaryMetric: "489kcal",
                            activityIcon: Image(systemName: "figure.strengthtraining.traditional")
                        )

                        ActivityWidgetCard(
                            clientImage: Image("joey_t"),
                            clientName: "Joseph Tribbiani",
                            date: Calendar.current.date(byAdding: .day, value: -10, to: .now)!,
                            color: .green,
                            primaryMetric: "45m",
                            secondaryMetric: "228lb",
                            activityIcon: Image(systemName: "figure.soccer")
                        )
                    }
                    .padding(.horizontal, 16)
                }
                
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

