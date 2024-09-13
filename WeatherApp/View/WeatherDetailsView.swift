//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 9/12/24.
//

import SwiftUI

struct WeatherDetailsView: View {
    var weather: Weather // Using the actual weather response model
    var weatherViewModel: WeatherViewModel
    
    var body: some View {
        VStack(spacing: Constants.Dimensions.firstSpacing) {
            
            HStack(spacing: Constants.Dimensions.secondSpacing) {
                VStack(alignment: .center) {
                    Text(weather.cityName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("\(weatherViewModel.weather?.temperature ?? 0.0, specifier: "%.1f")°C")
                        .font(.system(size: Constants.Font.mediumSize))
                    weatherViewModel.getWeatherIconFor(icon: weatherViewModel.weatherIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: (CGFloat(3)*(Constants.Dimensions.defaultPadding)),
                               height: (CGFloat(3)*(Constants.Dimensions.defaultPadding)),
                               alignment: .center)
                    
                    Text(weatherViewModel.weather?.weatherDescription.capitalized ?? "Conditions")
                        .font(.system(size: 20))
                }
                
            }
            HStack {
                Spacer()
                WidgetView(image: Constants.Images.wind,
                           text: Constants.Strings.windSpeed.localizated(),
                           title: weatherViewModel.windSpeed)
                Spacer()
                WidgetView(image: Constants.Images.humidity,
                           text: Constants.Strings.humidity.localizated(),
                           title: weatherViewModel.humidity)
                Spacer()
                WidgetView(image: Constants.Images.umbrella,
                           text: Constants.Strings.rainChances.localizated(),
                           title: "rain chances")
                Spacer()
            }
        }
        .padding()
        .foregroundStyle(.white)
        .background(
            RoundedRectangle(cornerRadius: Constants.Dimensions.cornerRadius)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: Constants.Colors.gradient),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
    private func WidgetView (image: String,
                             text: String,
                             title: String) -> some View {
        VStack {
            Text(text)
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: Constants.Dimensions.defaultWidth,
                       height: Constants.Dimensions.defaultHeight,
                       alignment: .center)
            Text(title)
        }
        .font(.system(size: Constants.Font.smallSize))
    }
}

