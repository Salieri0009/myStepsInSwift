//
//  RealmRouter.swift
//  pokeAPI
//
//  Created by Maxim on 23/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWork {
    private let realm = try! Realm()
    
    func getLoadData() -> [PokeData] {
        var arrayOfPokeData = [PokeData]()
        for elem in realm.objects(PokemonData.self) {
            if let pokeData = elem.pokeData {
                arrayOfPokeData.append(pokeData)
            }
        }
        return arrayOfPokeData
    }
    
    func write(pData: PokeData?) {
        if let pokeData = pData {
            let pokemonData = PokemonData()
            if let name = pokeData.name {
                try! realm.write({
                    pokemonData.name = name
                    pokemonData.pokeData = pokeData
                    realm.add(pokemonData, update: .modified)

                })
            }
        }
    }
    
    func isInWriteData(pData: PokeData) -> Bool {
        let findItems = realm.object(ofType: PokemonData.self, forPrimaryKey: pData.name)
        if findItems == nil {
            return false
        }
        else { return true}
    }
    
    func deleteInData(pData: PokeData){
        if let findItems = realm.object(ofType: PokemonData.self, forPrimaryKey: pData.name){
            try! self.realm.write({
                self.realm.delete(findItems)
            })
        }
    }
    
    func deleteInData(item: PokemonData){
        try! self.realm.write({
            self.realm.delete(item)
        })
    }
    
    func deleteInData(item: PokeData){
        let findItem = realm.object(ofType: PokemonData.self, forPrimaryKey: item.name)
        if let findItem = findItem{
            try! self.realm.write({
                self.realm.delete(findItem)
            })
        }
    }
}
