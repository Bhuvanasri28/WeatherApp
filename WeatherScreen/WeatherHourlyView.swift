//
//  WeatherHourlyView.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import SwiftUI

struct WeatherHourlyView: View {
    var weather: Weather
    var body: some View {
        VStack {
            Text(weather.weatherDescription)
                .font(.system(size: 15, weight: .medium, design: .default))
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    
                    ForEach(MockData.weatherMockData, id: \.self) { weatherData in
                        VStack {
                            Text(weatherData.time)
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.white)
                            Image(systemName: weatherData.imageURL)
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text(weatherData.temperature)
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.white)
                        }
                        .frame(width: 70)
                    }
                }
            }
        }
    }
}

#Preview {
    WeatherHourlyView(weather: MockWeatherData.sampleWeatherData)
}
