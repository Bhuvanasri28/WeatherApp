//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 9/12/24.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Main
    let weather: [WeatherElement]
    let wind: Wind   // Add wind information
    let name: String
    
    struct Main: Decodable {
        let temp: Double
        let humidity: Int  // Add humidity information
    }

    struct WeatherElement: Decodable {
        let description: String
        let icon: String
    }
    
    struct Wind: Decodable {  // New struct for wind data
        let speed: Double
    }
}
