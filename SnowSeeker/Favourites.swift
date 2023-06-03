//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Nikita Kolomoec on 03.06.2023.
//

import Foundation

class Favourites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favoutites"
    
    init() {
        // load our saved data
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        
    }
}
