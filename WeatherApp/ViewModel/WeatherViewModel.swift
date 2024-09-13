//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 9/12/24.
//
import Combine
import CoreLocation
import SwiftUI


class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var errorMessage: String?
    @Published var citySuggestions: [City] = []
    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherService

    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }

    func fetchWeather(for city: String) {
        weatherService.fetchWeather(for: city)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] weather in
                self?.weather = weather
            })
            .store(in: &cancellables)
    }

    func fetchCitySuggestions(for query: String) {
        weatherService.fetchCitySuggestions(for: query)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] cities in
                self?.citySuggestions = cities
            })
            .store(in: &cancellables)
    }
    
    var weatherIcon: String {
        return weather?.icon ?? "sun"
    }
    
    // New computed properties for humidity and wind speed
    var humidity: String {
        guard let humidity = weather?.humidity else { return "N/A" }
        return "\(humidity) %"
    }
    
    var windSpeed: String {
        guard let windSpeed = weather?.windSpeed else { return "N/A" }
        return "\(windSpeed) m/s"
    }

    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
            case "01d":
                return Image("sun")
            case "01n":
                return Image("moon")
            case "02d":
                return Image("cloudSun")
            case "02n":
                return Image("cloudMoon")
            case "03d":
                return Image("cloud")
            case "03n":
                return Image("cloudMoon")
            case "04d":
                return Image("cloudMax")
            case "04n":
                return Image("cloudMoon")
            case "09d":
                return Image("rainy")
            case "09n":
                return Image("rainy")
            case "10d":
                return Image("rainySun")
            case "10n":
                return Image("rainyMoon")
            case "11d":
                return Image("thunderstormSun")
            case "11n":
                return Image("thunderstormMoon")
            case "13d":
                return Image("snowy")
            case "13n":
                return Image("snowy-2")
            case "50d":
                return Image("tornado")
            case "50n":
                return Image("tornado")
            default:
                return Image("sun")
        }
    }
}

