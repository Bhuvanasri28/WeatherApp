//
//  WeatherHeaderView.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import SwiftUI

struct WeatherHeaderView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.weather?.cityName ?? "Atlanta")
                .font(.system(size: 30, weight: .medium, design: .default))
                .foregroundColor(.white)
            viewModel.getWeatherIconFor(icon: viewModel.weather?.icon ?? "sun")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
            Text("\(String(format: "%.0f", viewModel.weather?.temperature ?? 22))°C")
                .foregroundColor(Color.white)
                .font(.system(size: 40, weight: .semibold))
            Text(viewModel.weather?.description ?? "Cloudy")
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: .medium))
            Text(viewModel.weather?.weatherDescription ?? "Sunny")
                .foregroundColor(Color.white)
                .font(.system(size: 10, weight: .medium))
            HStack {
                Text("H: \(String(format: "%.0f", viewModel.weather?.maxTemperature ?? 27))°C")
                    .foregroundColor(Color.white)
                    .font(.system(size: 15, weight: .medium))
                Text("L: \(String(format: "%.0f", viewModel.weather?.minTemperature ?? 22))°C")
                    .foregroundColor(Color.white)
                    .font(.system(size: 15, weight: .medium))
            }
            Spacer()
        }.frame(height: 200)
            .padding(30)
        
    }
}

#Preview {
    WeatherHeaderView(viewModel: WeatherViewModel.mock)
}
