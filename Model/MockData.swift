//
//  MockData.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/5/24.
//

import Foundation

struct MockWeatherData {
    static let sampleWeatherData = Weather(
        cityName: "Atlanta",
        temperature: 12.7,
        weatherDescription: "Cool",
        description: "Partly cloudy",
        icon: "03d",
        humidity: 29,
        windSpeed: 14.5,
        windDirection: 120,
        visibility: 10000,
        rainVolume: 2.3,
        cloudCoverage: 83,
        minTemperature: 22,
        maxTemperature: 35,
        windGust: 3.47
    )
}

struct WeatherMockData: Hashable {
    let time: String
    let imageURL: String
    let temperature: String
}

struct MockData {
    static let weatherMockData = [WeatherMockData(time: "12PM", imageURL: "sun.max.fill", temperature: "23°C"), WeatherMockData(time: "1PM", imageURL: "sun.max.fill", temperature: "23°C"), WeatherMockData(time: "2PM", imageURL: "sun.max.fill", temperature: "23°C"), WeatherMockData(time: "3PM", imageURL: "sun.max.fill", temperature: "23°C"), WeatherMockData(time: "4PM", imageURL: "cloud.sun.fill", temperature: "23°C"), WeatherMockData(time: "5PM", imageURL: "cloud.sun.fill", temperature: "23°C"), WeatherMockData(time: "6PM", imageURL: "cloud.sun.fill", temperature: "23°C")]
}



