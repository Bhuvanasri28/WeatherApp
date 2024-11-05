//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/04/24.
//

struct WeatherResponse: Decodable {
    let name: String
    let main: MainWeather
    let weather: [WeatherElement]
    let wind: Wind
    let visibility: Int
    let clouds: Clouds
    let rain: Rain?
    
    struct MainWeather: Decodable {
        let temp: Double
        let humidity: Int
        let temp_min: Double
        let temp_max: Double
    }
    
    struct WeatherElement: Decodable {
        let description: String
        let icon: String
        let main: String
    }
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
    
    struct Rain: Decodable {
        let oneHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
        }
    }
}
