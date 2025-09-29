//
//  ClientsList.swift
//  FitTrack_iOS
//
//  Created by Luis Quintero on 18/09/25.
//

import SwiftUI

struct UserItem: Identifiable {
    let id: UUID
    var image: String
    var firstName: String
    var lastName: String
}

struct ClientCell: View {
    var client: UserItem
    
    var body: some View {
        HStack {
            // If client image exists
            let clientImage = client.image.isEmpty ? Image(systemName: "person") : Image(client.image)
            clientImage
                .resizable()
                .scaledToFill()          // Maintain proportion and fill the frame
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 8)) // Clip images as RoundedRectangles
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1)) // Gray order
                .shadow(radius: 1)       // Smooth shadow
            
            // Client Name and LastName
            VStack(alignment: .leading) {
                Text(client.firstName)
                    .font(.headline)
            }
            
            Spacer()
            
            // Chevron symbol to the right
            Image(systemName: "chevron.right")
                .foregroundStyle(.purple2)
        }
        
    } // ClientCell View
    
}

struct ClientsListView: View {
    // Used to hide Bottom Tab bar if needed
    @Binding var isTabBarHidden: Bool
    // Text varibale used to search Clients
    @State private var searchText = ""
    @State var clientsViewModel: ClientsViewModelProtocol
    
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
    var filteredList: [UserItem] {
        let list = searchText.isEmpty
        ? clientsViewModel.clients
        : clientsViewModel.clients.filter {
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
    var groupedClients: [String: [UserItem]] {
        Dictionary(grouping: filteredList) { client in
            String(client.firstName.prefix(1)) // Letter in each section (A, B, C)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Order the sections alphabetically
                ForEach(groupedClients.keys.sorted(), id: \.self) { key in
                    Section(header:
                                Text(key)
                        .font(.headline)
                        .foregroundColor(.purple2) // morado
                    ) {
                        // Show each client in the current section
                        ForEach(groupedClients[key]!) { client in
                            ClientCell(client: client)
                                .listRowSeparatorTint(.purple2)
                                .onTapGesture {
                                            // TODO: The action will be implemented here, for example:
                                            // selectedClient = client
                                            // showClientDetail = true
                                        }
                        }
                    }
                }
            }
            .navigationTitle("Lista de Clientes") // Screen Title
            .searchable(text: $searchText, prompt: "Buscar clientes") // Searchbar Hint Text
            .listStyle(.inset) // Remove gray list color
            .padding(.bottom, 24) // Used to end Client List at the same height as the MainTabBar Divider
        }.onAppear {
            clientsViewModel.load()
        }
    }
}


#Preview {
    ClientsListView(
        isTabBarHidden: .constant(false),
        clientsViewModel: ClientsViewModel()
    )
}
