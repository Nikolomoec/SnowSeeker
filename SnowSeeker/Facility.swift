//
//  Facility.swift
//  SnowSeeker
//
//  Created by Nikita Kolomoec on 03.06.2023.
//

import SwiftUI

struct Facility: Identifiable {
    let id = UUID()
    var name: String
    
    private let icons = [
        "Accommodation": "house",
        "Beginners": "1.circle",
        "Cross-country": "map",
        "Eco-friendly": "leaf.arrow.circlepath",
        "Family": "person.3"
    ]
    
    private let descriptions = [
        "Accommodation": "This resort has popular on-site accommodation.",
        "Beginners": "This resort has lots of ski schools.",
        "Cross-country": "This resort has many cross-country ski routes.",
        "Eco-friendly": "This resort has won award for envitomental friendliness.",
        "Family": "This resort is popular with families"
    ]
    
    var icon: some View {
        Image(systemName: icons[name]!)
            .accessibilityLabel(name)
            .foregroundColor(.secondary)
    }
    
    var description: String {
        descriptions[name]!
    }
    
}
