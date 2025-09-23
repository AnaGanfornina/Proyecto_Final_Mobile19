import SwiftUI

struct NewTrainingView: View {
    @Binding var selectedClient: String?
    // Used to hide Bottom Tab bar if needed
    @Binding var isTabBarHidden: Bool
    @Environment(\.dismiss) private var dismiss // Dismiss view
    @State var trainingViewModel: TrainingViewModel
    @State var disableCreateButton: Bool = false
    @State private var showAlert = false
    
    // Datos de ejemplo de clientes
    var clients = Client.self
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
            Divider()
            VStack(spacing: 16) {
                // Seleccionar cliente
                
                NavigationLink(
                    destination: ClientsListViewPicker(
                        selectedClient: $selectedClient,
                        isTabBarHidden: $isTabBarHidden)
                ) {
                    VStack {
                        Text("Cliente")
                            .modifier(TextStyle())
                        GeometryReader { geo in
                            let cardHeight = geo.size.height
                            HStack {
                                // TODO: Poner imagen del cliente seleccionado y un if por si aún no se selecciona cliente, poner imagen por defecto
                                Image("sarah")
                                    .resizable() // Makes image adapt frame size
                                    .aspectRatio(1, contentMode: .fill)
                                    .frame(width: cardHeight, height: cardHeight) // Card height used to fill the entire Card Height and width so its a perfect square
                                    .clipped()
                                    .clipShape(.containerRelative) /// Instead of corner raidus, it adjusts to its container cornerRadius
                        
                                // Select Client
                                Text(selectedClient ?? "Seleccionar cliente")
                                    .foregroundColor(selectedClient == nil ? .gray : .primary)
                                    .frame(width: 180)
                                // Chevron right
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding()
                            } // HStack
                            .background(.purple1.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
                            .frame(height: 72)
                        } // Geometry Reader
                        
                        .frame(height: 62) // Set the card height
                        .padding(.horizontal, 2)
                        .padding(.vertical, 4)
                        .padding(.bottom, 16)
                    }
                    
                }
                
                // Objective
                TextField("Objetivo", text: $objective)
                    .frame(height: 28)
                    .modifier(TextFieldStyle())
                    .padding(.bottom, 16)
                
                // Training section
                Text("Entrenamiento")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                // MARK: Training Date / Show Date Picker
                Button(action: { showDatePicker = true }) {
                    HStack {
                        // TODO: Poner imagen del cliente seleccionado y un if por si aún no se selecciona cliente, poner imagen por defecto
                        Image(systemName: "calendar")
                            .resizable() // Makes image adapt frame size
                            .frame(maxWidth: 30, maxHeight: 30)
                            .foregroundColor(.purple2)
                            .padding()
                        
                        // Select Date
                        Text((formattedDate(selectedDate)))
                            .foregroundColor(.primary)
                        
                        // Chevron right
                        Image(systemName: "chevron.right")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                    } // HStack
                    .background(.purple1.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
                }
                
                // MARK: Training Time / Show Time Picker
                Button(action: { showTimePicker = true }) {
                    HStack {
                        // TODO: Poner imagen del cliente seleccionado y un if por si aún no se selecciona cliente, poner imagen por defecto
                        Image(systemName: "clock")
                            .resizable() // Makes image adapt frame size
                            .frame(maxWidth: 30, maxHeight: 30)
                            .foregroundColor(.purple2)
                            .padding()
                        
                        // Select Time
                        Text(formattedTime(selectedTime))
                            .foregroundColor(.primary)
            
                        // Chevron right
                        Image(systemName: "chevron.right")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                    } // HStack
                    .background(.purple1.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
                }
                
                
                // MARK: Training Exercises / Show Exercises Picker
                NavigationLink(destination: AddExercisesView()) {
                    HStack {
                        // TODO: Poner imagen del cliente seleccionado y un if por si aún no se selecciona cliente, poner imagen por defecto
                        Image(systemName: "dumbbell")
                            .font(.title)
                            .foregroundColor(.purple2)
                            .padding(.leading, 12)
                        
                        // Select Client
                        Text("Ejercicios")
                            .foregroundColor(.primary)
                            .padding(.leading, 10)
                        
                        // Selected Exercises
                        Text(selectedExercises ?? "0")
                            .foregroundColor(.gray)
                            .padding(.leading, 100)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        // Chevron right
                        Image(systemName: "chevron.right")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing))
                            .frame(alignment: .trailing)
                            .padding()
                    } // HStack
                    .background(.purple1.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
                }
                
                
                Spacer()
                
                Button("Crear") {
                    trainingViewModel.create(
                        // TODO: Replace by training name
                        name: objective,
                        //TODO: Set from a Mock
                        traineeId: UUID(uuidString: "0B75E4C6-C4F1-4376-A77E-047987D70881") ?? UUID(),
                        scheduledAt: selectedDate
                    )
                }
                .padding()
                .frame(maxWidth: .infinity) // Large button
                .background(Color.purple2)
                .foregroundColor(.white)
                .cornerRadius(12)
                .font(.title3)        // tamaño del texto
                .fontWeight(.semibold)    // negrita
                .disabled(disableCreateButton)
                
                Spacer()
            } // VStack
            .padding()
            .navigationBarBackButtonHidden(true) /// Hide `< Back` button
            .toolbar {
                // Tool Bar at the Top
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 48) {
                        // Chevron to go back Home
                        Button {
                            dismiss()
                            isTabBarHidden = false // Show tab bar when going back
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(LinearGradient(colors: [.orange1, .red1], startPoint: .leading, endPoint: .trailing))
                        }
                        
                        // Texto junto al chevron
                        Text("Nuevo entrenamiento")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(minWidth: 150)
                        
                        
                    }
                } // Toolbar
            }
            .onChange(of: trainingViewModel.state, { oldValue, newValue in
                switch newValue {
                case .none:
                    debugPrint("None")
                case .loading:
                    disableCreateButton = true
                case .loaded:
                    dismiss()
                case .error:
                    disableCreateButton = false
                    showAlert = true
                }
                trainingViewModel.state = .none
            })
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
            .alert("Ocurrió un error", isPresented: $showAlert) {
                Button("Aceptar", role: .cancel) {
                    showAlert = false
                }
            }
            
        } // Navigation Stack
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





#Preview {
    NewTrainingView(selectedClient: .constant(nil), isTabBarHidden: .constant(false), trainingViewModel: TrainingViewModel())
}


/// A custom modifier for the TextFields
struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.white))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.7), lineWidth: 1.5)
            )
    }
}

/// A custom modifier for the Title Texts of each TextField
struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Custom image Modifier
struct ClientImageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
//            .scaledToFill()          // Maintain proportion and fill the frame
//            .frame(width: 48, height: 48)
//            .clipShape(RoundedRectangle(cornerRadius: 8)) // Clip images as RoundedRectangles
//            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1)) // Gray order
//            .shadow(radius: 1)       // Smooth shadow
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


