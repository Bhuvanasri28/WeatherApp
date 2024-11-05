//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Bhuvana Ravuri on 11/04/24.
//

import XCTest
import Combine
@testable import WeatherApp

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var mockWeatherService: MockWeatherService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockWeatherService = MockWeatherService()
        viewModel = WeatherViewModel(weatherService: mockWeatherService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockWeatherService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchWeatherUpdatesWeather() {
        let expectation = XCTestExpectation(description: "WeatherViewModel fetches and updates weather data")
        
        // Set mock weather data
        mockWeatherService.weather = Weather(cityName: "New York", temperature: 22.5, weatherDescription: "Clear sky", icon: "01d", humidity: 60, windSpeed: 5.0)
        
        // Fetch weather for a city
        print("Test: Fetching weather for New York")
        viewModel.fetchWeather(for: "New York")
        
        // Use sink on the @Published weather property
        viewModel.$weather
            .dropFirst()  // Ignore the initial value
            .sink(receiveValue: { weather in
                print("Test: Received updated weather data")
                XCTAssertNotNil(weather, "Weather should not be nil")
                XCTAssertEqual(weather?.cityName, "New York", "City name should be New York")
                XCTAssertEqual(weather?.temperature, 22.5, "Temperature should be 22.5")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10)
    }
}
