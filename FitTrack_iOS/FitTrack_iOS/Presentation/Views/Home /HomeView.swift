//
//  PrincipalView.swift
//  FitTrack_iOS
//
//  Created by Ana Ganfornina Arques on 5/9/25.
//

import SwiftUI

struct HomeView: View {
    // Used to hide Bottom Tab bar if needed
    @Binding var isTabBarHidden: Bool
    
    // Training ViewModel
    @State private var trainingViewModel = TrainingViewModel()
    
    @State private var selectedClient: String? = nil
    @State private var showCreateClient = false
    @State private var showNewTraining = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // MARK: - Top Profile HStack
                HStack(spacing: 16) {
                    Button(action: {
                        //TODO: Crear detalle de perfil
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
                        CreateClientView(isTabBarHidden: $isTabBarHidden, registerViewModel: RegisterViewModel())
                            .onAppear { isTabBarHidden = true }   // Hides TabBar
                            .onDisappear { isTabBarHidden = false } // Shows it when Back Home
                    }
                    .navigationDestination(isPresented: $showNewTraining) {

                        NewTrainingView(selectedClient: $selectedClient, isTabBarHidden: $isTabBarHidden, trainingViewModel: trainingViewModel)

                            .onAppear { isTabBarHidden = true }   // Hides TabBar
                    }

                
                // MARK: - Action Buttons (Crear Cliente / Nuevo Entrenamiento)
                HStack(spacing: 16) {
                    
                    // Create Client Button
                    Button(action: { showCreateClient = true }) {
                        VStack(spacing: 8) {
                            Image(systemName: "plus")
                                .font(.system(size: 36, weight: .medium))
                                .foregroundColor(.white) // símbolo blanco
                            
                            Text("Crear cliente")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white) // texto blanco
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.orange1, .red1],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10) // redondeado
                    }
                    .buttonStyle(.plain)
                    .scaleEffect(showCreateClient ? 0.8 : 1.0)
                    .animation(.spring(), value: showCreateClient)
                    
                    // New Training Button
                    Button(action: { showNewTraining = true }) {
                        VStack(spacing: 8) {
                            Image(systemName: "pencil.and.list.clipboard")
                                .font(.system(size: 36, weight: .medium))
                                .foregroundColor(.white) // símbolo blanco
                            
                            Text("Nuevo\nEntrenamiento")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white) // texto blanco
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.orange1, .red1],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10) // redondeado
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
                ScrollView(.vertical, showsIndicators: true) {
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
    HomeView(isTabBarHidden: .constant(false))
        .environment(AppState())
}

