//
//  ClientsView.swift
//  FitTrack_iOS
//
//  Created by Álvaro Entrena Casas on 13/9/25.
//

import SwiftUI

struct ClientsView: View {
    
    @State private var clients = ["Perico palotes", "Benito Camelas", "Nikito Nipongo"]
    
    var body: some View {
        NavigationStack {
            VStack{
                // Barra superior con botones
                HStack {
                    Button(action:{
                        print("Volver atrás")
                        // Aqui puedes usar dismiss() si quieres cerrar la vista
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 20, height: 30)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    
                    NavigationLink(destination: CreateClientView()) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                
                List {
                    ForEach(clients, id: \.self) { client in
                        Text(client)
                            .padding(.vertical, 8)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Clientes")
        }
    }
}

#Preview {
    ClientsView()
}
