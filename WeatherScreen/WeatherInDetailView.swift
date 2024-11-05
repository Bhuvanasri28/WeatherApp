//
//  WeatherInDetailView.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import SwiftUI

struct WeatherInDetailView: View {
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    var viewModel: WeatherViewModel
    
    var body: some View {
        if let weather = viewModel.weather {
            LazyVGrid(columns: columns) {
                VStack(alignment: .leading) {
                    Text("\(Image(systemName: "humidity")) HUMIDITY")
                        .bold()
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                    Text(viewModel.humidity)
                        .bold()
                        .font(.system(size: 25, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.bottom)
                    Text("Humidity is making it feel warmer")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }.padding()
                    .frame(height: 200)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(15)
                
                VStack(alignment: .leading) {
                    Text("\(Image(systemName: "eye.circle")) VISIBILITY")
                        .bold()
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                    Text("\(weather.visibilityInKm)")
                        .bold()
                        .font(.system(size: 25, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.bottom)
                    Text("Perfectly clear view")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
                .padding()
                .frame(height: 200)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(15)
                
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("\(Image(systemName: "wind")) WIND")
                    .bold()
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(.bottom)
                HStack() {
                    Text("Wind")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(weather.windSpeedInMph)")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.white)
                HStack() {
                    Text("Gusts")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(weather.windGustInMph)")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.white)
                HStack() {
                    Text("Direction")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(weather.formattedWindDirection)")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(height: 200)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.blue.opacity(0.2))
            .cornerRadius(15)
            VStack(alignment: .leading) {
                Text("\(Image(systemName: "cloud.rain")) RAIN")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(.bottom)
                Text("\(weather.formattedRainVolume)")
                    .bold()
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(.bottom)
                Text("Cloud Coverage: \(weather.cloudCoverageDescription)")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
            }
            .padding()
            .frame(height: 150)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.blue.opacity(0.2))
            .cornerRadius(15)
        }
    }
}



#Preview {
    WeatherInDetailView(viewModel: WeatherViewModel.mock)
}
