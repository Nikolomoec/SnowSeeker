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
            do {
                resorts = try JSONDecoder().decode(Set<String>.self, from: data)
                return
            } catch {
                print("Failed decoding data from UserDefaults")
                resorts = []
            }
        } else {
            resorts = []
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
