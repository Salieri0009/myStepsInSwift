//
//  PokeData.swift
//  pokeAPI
//
//  Created by Maxim on 08/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

struct PokeData: Codable {
    let name: String?
    let game_indices: [GameInfor]
    let location_area_encounters: String?
    let sprites: Sprites
    let stats: [Stats]
    let types: [Type]
}

struct GameInfor: Codable {
    var game_index: Int
    var version: BaseInfor
}

struct Sprites: Codable {
    var back_default: String?
    var back_female: String?
    var back_shiny: String?
    var back_shiny_female: String?
    var front_default: String?
    var front_female: String?
    var front_shiny: String?
    var front_shiny_female: String?
}

struct Stats: Codable {
    var base_stat: Int
    var stat: BaseInfor
}

struct Type: Codable{
    var slot: Int?
    var type: BaseInfor?
}
