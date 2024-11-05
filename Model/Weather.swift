//
//  Weather.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import Foundation

struct Weather {
    var cityName: String
    var temperature: Double
    var weatherDescription: String
    var description: String
    var icon: String
    var humidity: Int
    var windSpeed: Double
    var windDirection: Int
    var visibility: Int
    var rainVolume: Double?
    var cloudCoverage: Int
    var minTemperature: Double
    var maxTemperature: Double
    var windGust: Double?
    
}

extension Weather {
    var visibilityInKm: String {
        return "\(visibility / 1000) km"
    }
    
    var windDirectionCompass: String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"]
        let index = Int((Double(windDirection) / 45.0).rounded()) % 8
        return directions[index]
    }
    
    var formattedWindDirection: String {
        return "\(windDirection)° \(windDirectionCompass)"
    }
    
    var windSpeedInMph: String {
        let speedInMph = windSpeed * 2.237
        return String(format: "%.1f mph", speedInMph)
    }
    
    var windGustInMph: String {
        guard let gust = windGust else { return "No Gust" }
        let gustInMph = gust * 2.237
        return String(format: "%.1f mph", gustInMph)
    }

    var formattedRainVolume: String {
        guard let rainVolume = rainVolume else { return "No Rain" }
        return "\(rainVolume) mm"
    }
    
    var cloudCoverageDescription: String {
        return "\(cloudCoverage) %"
    }
}


