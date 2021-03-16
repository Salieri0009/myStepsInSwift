//
//  PokeLocation.swift
//  pokeAPI
//
//  Created by Maxim on 08/06/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

struct PokeLocation: Codable {
    var location_area: BaseInfor?
    var version_details: [VersionDetails]
}

struct VersionDetails: Codable {
    var encounter_details: [EncountersDetails]
    var version: BaseInfor
}

struct EncountersDetails: Codable {
    var chance: Int
    var method: BaseInfor
}
