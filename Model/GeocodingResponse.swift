//
//  GeocodingResponse.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import Foundation

struct GeocodingResponse: Decodable {
    let name: String
    let lat: Double
    let lon: Double
}
