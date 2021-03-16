//
//  RealmData.swift
//  pokeAPI
//
//  Created by Maxim on 17/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import RealmSwift

class PokemonData: Object {
    @objc dynamic var name = ""
    
    @objc private dynamic var structData: Data? = nil
    
    var pokeData: PokeData? {
        get {
            if let data = structData {
                return try? JSONDecoder().decode(PokeData.self, from: data)
            }
            return nil
        }
        set {
            structData = try? JSONEncoder().encode(newValue)
        }
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

