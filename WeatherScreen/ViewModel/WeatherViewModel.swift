//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/04/24.
//
import Combine
import CoreLocation
import SwiftUI
import UIKit

class WeatherViewModel: NSObject, ObservableObject {
    
    @Published var weather: Weather?
    @Published var errorMessage: String?
    @Published var citySuggestions: [City] = []
    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherService
    private let locationManager = CLLocationManager()
    private let userDefaultsKey = "lastSearchedCity"
    private let defaultCity = "New York"
    
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
        super.init()
        locationManager.delegate = self
    }
    
    func fetchWeather(for city: String) {
        weatherService.fetchWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    DispatchQueue.main.async {
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }, receiveValue: { [weak self] weather in
                DispatchQueue.main.async {
                    self?.weather = weather
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchCitySuggestions(for query: String) {
        weatherService.fetchCitySuggestions(for: query)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    DispatchQueue.main.async {
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }, receiveValue: { [weak self] cities in
                DispatchQueue.main.async {
                    self?.citySuggestions = cities
                }
            })
            .store(in: &cancellables)
    }
    
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
    
    // Load the last searched city if available or load default city
    func loadLastSearchedCityOrDefault() {
        if let lastCity = UserDefaults.standard.string(forKey: userDefaultsKey) {
            fetchWeather(for: lastCity)
        } else {
            fetchWeather(for: defaultCity)
            errorMessage = "Showing weather for \(defaultCity) as no previous search exists."
        }
    }
    
    // Request location access
    func requestLocationAccess() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Fetch weather based on latitude and longitude
    private func fetchWeatherForLocation(latitude: Double, longitude: Double) {
        weatherService.fetchWeather(forLatitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    DispatchQueue.main.async {
                        self?.errorMessage = error.localizedDescription
                        self?.loadLastSearchedCityOrDefault()  // Fallback to last searched city if fetching location-based weather fails
                    }
                }
            }, receiveValue: { [weak self] weather in
                DispatchQueue.main.async {
                    self?.weather = weather
                }
            })
            .store(in: &cancellables)
    }
}

extension WeatherViewModel {
    static var mock: WeatherViewModel {
        let viewModel = WeatherViewModel()
        
        viewModel.weather = Weather(
            cityName: "San Francisco",
            temperature: 20.0,
            weatherDescription: "Clear Sky",
            description: "Cloudy",
            icon: "01d",
            humidity: 60,
            windSpeed: 5.0,
            windDirection: 135,
            visibility: 10000,
            rainVolume: nil,
            cloudCoverage: 20,
            minTemperature: 22,
            maxTemperature: 27
        )
        
        return viewModel
    }
}


extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation() // Request location if authorized
        case .denied, .restricted:
            loadLastSearchedCityOrDefault() // Fall back to the last searched city if location is denied
            errorMessage = "Location access denied. Showing weather for the last searched city." // Optional: Show a message
        case .notDetermined:
            break // Do nothing, as permission is not yet determined
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        fetchWeatherForLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Failed to retrieve location. Showing weather for the last searched city."
        loadLastSearchedCityOrDefault() // Fallback if location fetching fails
    }
}
