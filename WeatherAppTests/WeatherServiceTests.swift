//
//  WeatherServiceTests.swift
//  WeatherAppTests
//
//  Created by Bhuvana Ravuri on 11/04/24.
//

import UIKit
import XCTest
import Combine
@testable import WeatherApp

class WeatherServiceTests: XCTestCase {
    
    var weatherService: WeatherService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        weatherService = WeatherService()
        cancellables = []
    }
    
    override func tearDown() {
        weatherService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchWeatherSuccess() {
        let expectation = XCTestExpectation(description: "Fetch weather successfully")
        weatherService.fetchWeather(for: "New York")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { weather in
                XCTAssertEqual(weather.cityName, "New York", "City name should be New York")
                XCTAssertNotNil(weather.temperature, "Temperature should not be nil")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchWeatherFailure() {
        let expectation = XCTestExpectation(description: "Fail to fetch weather for invalid city")
        weatherService.fetchWeather(for: "InvalidCityName")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertNotNil(error, "Error should be returned for invalid city")
                    expectation.fulfill()
                case .finished:
                    XCTFail("Should not complete successfully for an invalid city")
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive weather data for invalid city")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
}





