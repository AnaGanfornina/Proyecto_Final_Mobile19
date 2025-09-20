//
//  ClientsList.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI
// TODO: Use Real Models or future Mock Models
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
            // If client image exists
            if let clientImage = client.clientImage {
                clientImage
                    .resizable()
                    .scaledToFill()          // Maintain proportion and fill the frame
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 8)) // Clip images as RoundedRectangles
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1)) // Gray order
                    .shadow(radius: 1)       // Smooth shadow
                // If Client Image doesn't exist use a default Image
            } else {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFill()          // Maintain proportion and fill the frame
                    .frame(width: 40, height: 40)
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
    // TODO: This will eventually be cleaned up and pulled from a mock located elsewhere.
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
        Client(id: UUID(), clientImage: Image(["sarah", "joey_t", "benito_bodoque"].randomElement()!), firstName: "Tomás", lastName: "Alvarado"),
        Client(id: UUID(), clientImage: Image("sarah"), firstName: "Ana", lastName: "Ganfornina"),
        Client(id: UUID(), clientImage: Image("sarah"), firstName: "Ana", lastName: "Ganfornina"),
        Client(id: UUID(), firstName: "Sarah", lastName: "Ganfornina")
    ]
    
    // Text varibale used to search Clients
    @State private var searchText = ""
    
    /// Filtered and sorted list of clients based on the search text.
    ///
    /// - If `searchText` is empty, all clients from `mockClients` are returned.
    /// - If `searchText` has a value, the list is filtered to include only clients
    ///   whose `firstName` or `lastName` **begins with** the entered text, or whose
    ///   full name (`firstName` + " " + `lastName`) begins with the search text.
    ///   This is performed using `hasPrefix`, which checks if a string starts with a given prefix.
    ///
    /// The final list is sorted alphabetically:
    /// 1. By `firstName`.
    /// 2. If two clients have the same `firstName`, then by `lastName`.
    var filteredList: [Client] {
        let list = searchText.isEmpty
        ? mockClients
        : mockClients.filter {
            /// `lowerSearch` used to  convert everything to lowercase for case-insensitive comparison
            let lowerSeach = searchText.lowercased()
            let firstName = $0.firstName.lowercased() // Name
            let lastName = $0.lastName.lowercased() // LastName
            let fullName = "\(firstName) \(lastName)" // Full Name
            
            // Return true if the search text matches the start of firstName, lastName, or fullName
            return firstName.hasPrefix(lowerSeach) ||
            lastName.hasPrefix(lowerSeach) ||
            fullName.hasPrefix(lowerSeach)
        }
        // Sort alphabetically by firstName, then lastName if firstNames are equal
        return list.sorted {
            if $0.firstName.localizedCaseInsensitiveCompare($1.firstName) == .orderedSame {
                return $0.lastName.localizedCaseInsensitiveCompare($1.lastName) == .orderedAscending
            } else {
                return $0.firstName.localizedCaseInsensitiveCompare($1.firstName) == .orderedAscending
            }
        }
    }
    
    /// Dictionary that groups clients by the initial letter of their first name.
    ///
    /// - Uses `filteredList` as the source, so only clients that match the search text are included.
    /// - The key is the first letter of the `firstName`. Uppercased as Default
    /// - The value is an array of `Client` objects whose `firstName` starts with that letter.
    var groupedClients: [String: [Client]] {
        Dictionary(grouping: filteredList) { client in
            String(client.firstName.prefix(1)) // Letter in each section (A, B, C)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Order the sections alphabetically
                ForEach(groupedClients.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        // Show each client in the current section
                        ForEach(groupedClients[key]!) { client in
                            ClientCell(client: client)
                        }
                    }
                }
            }
            .navigationTitle("Lista de Clientes") // Screen Title
            .searchable(text: $searchText, prompt: "Buscar clientes") // Searchbar Hint Text
            .listStyle(.inset) // Remove gray list color
            .padding(.bottom, 24) // Used to end Client List at the same height as the MainTabBar Divider
        }
    }
}


#Preview {
    ClientsListView()
}
