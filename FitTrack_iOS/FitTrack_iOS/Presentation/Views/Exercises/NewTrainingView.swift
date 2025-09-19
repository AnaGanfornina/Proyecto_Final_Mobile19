import SwiftUI

struct NewTrainingView: View {
    @Binding var selectedClient: String?
    @Environment(\.dismiss) private var dismiss
    
    // Datos de ejemplo de clientes
    let clients = ["Perico palotes", "Benito Camelas", "Nikito Nipongo"] // MOCK momentaneo, mas adelante API
    let exercises = ["Bench press", "Squat", "Deadlift", "Pull-up", "Shoulder Press", "Bicep Curl"] // MOCK momentaneo, mas tarde API
    
    @State private var showClientList = false
    
    @State private var objective = ""
    
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    @State private var selectedTime = Date()
    @State private var showTimePicker = false
    
    @State private var selectedExercises: String? = nil
    
    
    var body: some View {
        NavigationStack {
            Form {
                // Seleccionar cliente
                Section {
                    NavigationLink(destination: ClientListView(clients: clients, selectedClient: $selectedClient)) {
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
                    NavigationLink(destination: AddExercisesView()) {
                        HStack {
                            Text("Seleccionar ejercicios")
                            Spacer()
                            Text(selectedExercises ?? "0")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }

                        Spacer()
                        Button("Crear") {
                            print("Cliente: \(selectedClient ?? "Ninguno")")
                            print("Objetivo: \(objective)")
                            print("Fecha: \(selectedDate)")
                            print("Hora: \(selectedTime)")
                            dismiss()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        Spacer()
            
                .navigationTitle("Nuevo entrenamiento")
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


#Preview {
    NewTrainingView(selectedClient: .constant(nil))
}
