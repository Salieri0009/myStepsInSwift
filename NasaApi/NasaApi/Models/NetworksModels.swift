//
//  NetworksModels.swift
//  NasaApi
//
//  Created by Maxim on 02/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

struct ApodData: Codable {
    let date: String
    let explanation: String
    let media_type: String
    let title: String
    let url: String
}

struct NeoData: Codable {
    let links: Links
    let near_earth_objects: [String:[NearEarthObjects]]
}

struct Links: Codable {
    let next: String?
    let prev: String?
    let `self`: String
}

struct NearEarthObjects: Codable {
    let links: Links
    let name: String
    let id: String
    let neo_reference_id: String
    let nasa_jpl_url: String
    let estimated_diameter: EstimatedDiametr
    let absolute_magnitude_h: Double
}

struct EstimatedDiametr: Codable {
    let kilometers: EstimatedDiametrKilometres
}

struct EstimatedDiametrKilometres: Codable {
    let estimated_diameter_min: Double
    let estimated_diameter_max: Double
}

