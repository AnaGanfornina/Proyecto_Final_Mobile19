//
//  ClientsList.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI

struct Client: Identifiable {
    let id: UUID
    var clientImage: Image? = nil
    var firstName: String
    var lastName: String
}

struct ClientCell: View {
    
    var client: Client
    
    var body: some View {
        HStack {
            if let clientImage = client.clientImage {
                clientImage
                    .resizable()
                    .scaledToFill()          // Maintain proportion and fill the frame
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 8)) // Clip images as RoundedRectangles
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1)) // Gray order
                    .shadow(radius: 1)       // Smooth shadow
            }
            
            // Client Name and LastName
            VStack(alignment: .leading) {
                Text("\(client.firstName) \(client.lastName)")
                    .font(.headline)
            }
            
            Spacer()
            
            // Chevron symbol to the right
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        
    } // ClientCell View
    
}

struct ClientsListView: View {
    
    let mockClients: [Client] = [
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Luis", lastName: "Quintero"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Ana", lastName: "García"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Carlos", lastName: "Pérez"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Marta", lastName: "López"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Jorge", lastName: "Ramírez"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Sofía", lastName: "Hernández"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "David", lastName: "Martínez"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Lucía", lastName: "González"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Fernando", lastName: "Torres"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Carla", lastName: "Vargas"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Miguel", lastName: "Rojas"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Valeria", lastName: "Castillo"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Andrés", lastName: "Molina"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Paula", lastName: "Santos"),
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Tomás", lastName: "Alvarado")
    ]
    
    // Varibale for searching Clients
    @State private var searchText = ""
    
    // Filtering and Ordering Clients
    var filteredList: [Client] {
        let list = searchText.isEmpty ? mockClients : mockClients.filter { $0.firstName.localizedCaseInsensitiveContains(searchText) }
        return list.sorted { $0.firstName.localizedCaseInsensitiveCompare($1.firstName) == .orderedAscending }
    }
    
    // Groups by initial letter
    var groupedClients: [String: [Client]] {
        Dictionary(grouping: filteredList) { client in
            String(client.firstName.prefix(1)).uppercased()
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Order the sections alphabetically
                ForEach(groupedClients.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(groupedClients[key]!) { client in
                            ClientCell(client: client)
                        }
                    }
                }
            }
            .navigationTitle("Lista de Clientes")
            .searchable(text: $searchText, prompt: "Buscar clientes")
            .listStyle(.inset)
            .padding(.bottom, 24) // Used to end Client List at the same height as the MainTabBar Divider
        }
    }
}


#Preview {
    ClientsListView()
}
