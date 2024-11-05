//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import Combine
import Foundation
import CoreLocation

class WeatherService {
    private let apiKey = "1dcc5f1ac475526107abeea81e5bf2b7"  // Replace with your actual API key
    private let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let geocodingBaseURL = "https://api.openweathermap.org/geo/1.0/direct"
    
    func fetchWeather(for city: String) -> AnyPublisher<Weather, Error> {
        return fetchCoordinates(for: city)
            .flatMap { coordinate in
                self.fetchWeather(for: coordinate)
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchCoordinates(for city: String) -> AnyPublisher<CLLocationCoordinate2D, Error> {
        // Encode the city name to handle spaces and special characters
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        // Construct the URL string
        let urlString = "\(geocodingBaseURL)?q=\(encodedCity)&limit=1&appid=\(apiKey)"
        
        // Debugging print statement
        print("Geocoding URL: \(urlString)")
        
        // Validate the URL
        guard let url = URL(string: urlString) else {
            print("Failed to create URL")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
//            .tryMap { data in
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Raw JSON Response: \(jsonString)")
//                }
//                return data
//            }
            .decode(type: [GeocodingResponse].self, decoder: JSONDecoder())
            .tryMap { geocodingResponse in
                guard let location = geocodingResponse.first else {
                    throw URLError(.badServerResponse)
                }
                return CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchWeather(for coordinate: CLLocationCoordinate2D) -> AnyPublisher<Weather, Error> {
        let urlString = "\(weatherBaseURL)?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric"
        
        print("Weather URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Failed to create URL")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map { response in
                return Weather(
                    cityName: response.name,
                    temperature: response.main.temp,
                    weatherDescription: response.weather.first?.description ?? "",
                    description: response.weather.first?.main ?? "",
                    icon: response.weather.first?.icon ?? "",
                    humidity: response.main.humidity,
                    windSpeed: response.wind.speed,
                    windDirection: response.wind.deg,
                    visibility: response.visibility,
                    rainVolume: response.rain?.oneHour ?? 0.0, // Default to 0.0 if `oneHour` is nil
                    cloudCoverage: response.clouds.all,
                    minTemperature: response.main.temp_min,
                    maxTemperature: response.main.temp_max
                )
            }
            .eraseToAnyPublisher()
    }
    
    func fetchCitySuggestions(for query: String) -> AnyPublisher<[City], Error> {
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let urlString = "\(geocodingBaseURL)?q=\(queryEncoded)&limit=5&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [City].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchWeather(forLatitude latitude: Double, longitude: Double) -> AnyPublisher<Weather, Error> {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return fetchWeather(for: coordinate) // Reuse the private method
    }
    
}

// City model for decoding Geocoding API response
struct City: Identifiable, Decodable {
    let id = UUID()  // To conform to Identifiable for SwiftUI List
    let name: String
    let country: String
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case name, country, state
    }
}

