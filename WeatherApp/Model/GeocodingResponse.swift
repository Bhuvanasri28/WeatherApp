//
//  GeocodingResponse.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 9/12/24.
//

import Foundation

struct GeocodingResponse: Decodable {
    let name: String
    let lat: Double
    let lon: Double
}
