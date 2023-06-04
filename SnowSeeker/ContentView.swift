//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Nikita Kolomoec on 02.06.2023.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

enum SortingOptions {
    case name, country, favourites
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favourites = Favourites()
    @State private var searchText = ""
    
    @State private var showingSorting = false
    @State private var sortBy: SortingOptions = .favourites
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favourites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This a favourite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search Resorts")
            .confirmationDialog("Sort by...", isPresented: $showingSorting) {
                Button("Name") { sortBy = .name }
                Button("Country") { sortBy = .country }
                Button("Favourites") { sortBy = .favourites }
            } message: {
                Text("Sort by...")
            }
            .toolbar {
                Button {
                    showingSorting = true
                } label: {
                    Label("Sort by", systemImage: "arrow.up.arrow.down")
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favourites)
        .phoneOnlyNavigationView()
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return sortedResorts()
        } else {
            return sortedResorts().filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    func sortedResorts() -> [Resort] {
        switch sortBy {
        case .name:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        case .favourites:
            return resorts.sorted { first, _ in
                favourites.contains(first)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
