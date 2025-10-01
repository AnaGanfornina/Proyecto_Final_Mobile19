//
//  DatePickerSheet.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 23/09/25.
//

import SwiftUI

// MARK: Floating Sheet for Selecting Date
/// A view that allows the user to select a date and Time
/// The sheet includes a title, a graphical DatePicker, and Cancel/Done buttons.
struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    @Binding var showSheet: Bool

    var body: some View {
            VStack(spacing: 16) {
                // MARK: Title
                Text("Selecciona una fecha")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)

                Divider()

                // MARK: Graphical DatePicker
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .padding(.horizontal)

                Divider()

                // MARK: Cancel and Done Buttons
                HStack {
                    // Cancel button
                    Button("Cancelar") {
                        showSheet = false
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.red1)
                    .cornerRadius(12)
                    .font(.title3)
                    .fontWeight(.semibold)

                    Spacer()
                    
                    // Done button
                    Button("Listo") {
                        showSheet = false
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(12)
                    .font(.title3)
                    .fontWeight(.semibold)
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 24)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .animation(.spring(), value: showSheet)
    }
}

// MARK: - Floating Sheet for Selecting a Time
/// The sheet includes a title, a wheel-style TimePicker, and Cancel/Done buttons.
struct TimePickerSheet: View {
    @Binding var selectedTime: Date
    @Binding var showSheet: Bool

    var body: some View {
        
        VStack(spacing: 16) {
            // MARK: Title
            Text("Selecciona una hora")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            Divider()

            // MARK: Wheel-style TimePicker
            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding(.horizontal)

            Divider()

            // MARK: Cancel and Done Buttons
            HStack {
                // Cancel Button
                Button("Cancelar") {
                    showSheet = false
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.red1)
                .cornerRadius(12)
                .font(.title3)
                .fontWeight(.semibold)

                Spacer()

                // Done Button
                Button("Listo") {
                    showSheet = false
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(12)
                .font(.title3)
                .fontWeight(.semibold)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 24)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.spring(), value: showSheet)
    }
}

// MARK: - Previews
struct PickerSheets_Previews: PreviewProvider {
    @State static var date = Date()
    @State static var showDate = true
    @State static var time = Date()
    @State static var showTime = true

    static var previews: some View {
        // Select view at the top of the Preview window
        Group {
            // Preview for DatePickerSheet
            DatePickerSheet(selectedDate: $date, showSheet: $showDate)
                .previewDisplayName("Date Picker Sheet")
            
            // Preview for TimePickerSheet
            TimePickerSheet(selectedTime: $time, showSheet: $showTime)
                .previewDisplayName("Time Picker Sheet")
        }
        .preferredColorScheme(.light) // You can toggle between .dark and .light
    }
}
