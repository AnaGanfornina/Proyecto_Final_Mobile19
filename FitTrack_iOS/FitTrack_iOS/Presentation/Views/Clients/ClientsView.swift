//
//  ClientsView.swift
//  FitTrack_iOS
//
//  Created by Álvaro Entrena Casas on 13/9/25.
//

import SwiftUI

struct ClientsView: View {
    @Binding var selectedClient: String?
    @Environment(\.dismiss) private var dismiss
    @State private var clients = ["Perico palotes", "Benito Camelas", "Nikito Nipongo"]
    
    var body: some View {
        NavigationStack {
            VStack{
                // Barra superior con botones
               
                NavigationLink(destination: CreateClientView()) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                }
                
                .padding()
                
                List {
                    ForEach(clients, id: \.self) { client in
                        Button(action: {
                            selectedClient = client
                            dismiss()
                        }){
                            Text(client)
                                .padding(.vertical, 8)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Clientes")
        }
    }
}

#Preview {
    ClientsView(selectedClient: .constant(nil))
}
