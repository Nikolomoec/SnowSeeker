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
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
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
        let encodedData = try? JSONEncoder().encode(resorts)
        
        UserDefaults.standard.set(encodedData, forKey: saveKey)
    }
}
