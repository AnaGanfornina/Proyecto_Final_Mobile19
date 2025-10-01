//
//  CalendarView.swift
//  FitTrack_iOS
//
//  Created by Álvaro Entrena Casas on 13/9/25.
//

import SwiftUI

struct CalendarView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedDate = Date()
    @State private var appointments: [Date: [String]] = [:]
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
               Spacer()
            }
            .padding()
//            VStack {
//                DatePicker("Selecciona una fecha",
//                           selection: $selectedDate,
//                           displayedComponents: .date)
//                .datePickerStyle(.graphical)
//                .padding()
//            }
            HStack{
                ForEach(currentWeekDates, id: \.self) { date in
                    VStack {
                        Text(dayFormatter.string(from: date))
                            .font(.headline)
                        Text(dateFormatter.string(from: date))
                            .font(.caption)
                    }
                    .padding()
                    .background(Calendar.current.isDate(date, inSameDayAs: selectedDate) ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
                    .onTapGesture {
                        selectedDate = date
                    }
                }
            } // HStack
            
            .padding(.horizontal)
            
            List {
                ForEach(upcomingAppointments, id: \.self) { appointment in
                    Text(appointment)
                }
            }
        }
        .onAppear {
            selectedDate = Date()
            generateSampleAppointments()
        }
    }
    
    
    private var currentWeekDates: [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        guard let weekStart = calendar.date(byAdding: .day, value: -(weekday - calendar.firstWeekday), to: calendar.startOfDay(for: today)) else {
            return []
        }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: weekStart) }
    }
    
    private var upcomingAppointments: [String] {
        let todayIndex = currentWeekDates.firstIndex(where: { Calendar.current.isDateInToday($0) }) ?? 0
        let datesToShow = currentWeekDates[todayIndex..<currentWeekDates.count]
        return datesToShow.flatMap { appointments[$0] ?? [] }
    }
    
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }
    
    private func generateSampleAppointments() {
        let calendar = Calendar.current
        var sampleAppointments: [Date: [String]] = [:]
        for date in currentWeekDates {
            let dayNumber = calendar.component(.day, from: date)
            sampleAppointments[date] = [
                "Appointment \(dayNumber)-1",
                "Appointment \(dayNumber)-2",
                "Appointment \(dayNumber)-3"
            ]
        }
        appointments = sampleAppointments
    }
}

#Preview {
    CalendarView()
}
