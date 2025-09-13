import SwiftUI

struct NewTrainingView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Datos de ejemplo de clientes
    let clients = ["Perico palotes", "Benito Camelas", "Nikito Nipongo"]
    let exercises = ["Bench press", "Squat", "Deadlift", "Pull-up", "Shoulder Press", "Bicep Curl"]
    
    @State private var selectedClient: String? = nil
    @State private var showClientList = false
    
    @State private var objective = ""
    
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    @State private var selectedTime = Date()
    @State private var showTimePicker = false
    
    @State private var selectedExercises: String? = nil
    @State private var showExercisesList = false
    
    var body: some View {
        NavigationStack {
            Form {
                // Seleccionar cliente
                Section {
                    Button(action: { showClientList = true }) {
                        HStack {
                            Text("Cliente")
                            Spacer()
                            Text(selectedClient ?? "Seleccionar cliente")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // Escribir objetivo
                Section(header: Text("Objetivo")) {
                    TextField("Escribe el objetivo de la cita", text: $objective)
                }
                
                // Seleccionar fecha
                Section {
                    Button(action: { showDatePicker = true }) {
                        HStack {
                            Text("Fecha")
                            Spacer()
                            Text(formattedDate(selectedDate))
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // Seleccionar hora
                Section {
                    Button(action: { showTimePicker = true }) {
                        HStack {
                            Text("Hora")
                            Spacer()
                            Text(formattedTime(selectedTime))
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section {
                    Button(action: { showExercisesList = true }) {
                        HStack {
                            Text("Seleccionar ejercicios")
                            Spacer()
                            Text(selectedExercises ?? "0")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Nueva Cita")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Crear") {
                        print("Cliente: \(selectedClient ?? "Ninguno")")
                        print("Objetivo: \(objective)")
                        print("Fecha: \(selectedDate)")
                        print("Hora: \(selectedTime)")
                        dismiss()
                    }
                }
            }
            // Navegación a lista de clientes
            
            // TODO: Enlazar bien la lista de clientes
            .sheet(isPresented: $showClientList) {
                ClientListView(clients: clients, selectedClient: $selectedClient)
            }
            // Selector de fecha
            .sheet(isPresented: $showDatePicker) {
                DatePicker("Selecciona una fecha", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
            }
            // Selector de hora
            .sheet(isPresented: $showTimePicker) {
                DatePicker("Selecciona una hora", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .padding()
            }
            // TODO: Enlazar bien la lista de ejercicios
            .sheet(isPresented: $showExercisesList) {
                ExercisesListView(selectedExercise: $selectedExercises)
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct ClientListView: View {
    let clients: [String]
    @Binding var selectedClient: String?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List(clients, id: \.self) { client in
                Button(client) {
                    selectedClient = client
                    dismiss()
                }
            }
            .navigationTitle("Seleccionar Cliente")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ExercisesListView: View {
    @Binding var selectedExercise: String?
    @Environment(\.dismiss) private var dismiss

    let exercises = ["Bench press", "Squat", "Deadlift", "Pull-up", "Shoulder Press", "Bicep Curl"]

    var body: some View {
        NavigationStack {
            List(exercises, id: \.self) { exercise in
                Button(exercise) {
                    selectedExercise = exercise
                    dismiss()
                }
            }
            .navigationTitle("Ejercicios")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    NewTrainingView()
}
