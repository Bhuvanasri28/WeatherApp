//
//  MockWeatherService.swift
//  WeatherAppTests
//
//  Created by Bhuvana Ravuri on 9/12/24.
//

import Foundation
import Combine
@testable import WeatherApp

class MockWeatherService: WeatherService {
    var weather: Weather?  // Mock weather data to be returned
    var shouldReturnError: Bool = false  // Simulate an error response
    
    override func fetchWeather(for city: String) -> AnyPublisher<Weather, Error> {
        print("MockWeatherService: Fetching weather for \(city)")
        
        if shouldReturnError {
            print("MockWeatherService: Simulating error response")
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else if let weather = weather {
            print("MockWeatherService: Returning mock weather data for \(city)")
            return Just(weather)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            print("MockWeatherService: No weather data set, returning error")
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }
    
    override func fetchCitySuggestions(for query: String) -> AnyPublisher<[City], Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else {
            let mockCities = [
                City(name: "New York", country: "US", state: "NY"),
                City(name: "Los Angeles", country: "US", state: "CA")
            ]
            return Just(mockCities)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
