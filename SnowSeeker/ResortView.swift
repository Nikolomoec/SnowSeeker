//
//  SecondaryView.swift
//  SnowSeeker
//
//  Created by Nikita Kolomoec on 03.06.2023.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    let resort: Resort
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    @EnvironmentObject var favourites: Favourites
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    
                    Button(favourites.contains(resort) ? "Remove from Favourites" : "Add to Favourites") {
                        if favourites.contains(resort) {
                            favourites.remove(resort)
                        } else {
                            favourites.add(resort)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "Unknown", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

struct SecondaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
        }
        .environmentObject(Favourites())
    }
}
