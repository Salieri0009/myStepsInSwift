//
//  PokeCellData.swift
//  pokeAPI
//
//  Created by Maxim on 08/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

struct PokeCell {
    var name: String?
    var image: Sprites?
    var encounters: [String?]
    var stats: Stats?
}
