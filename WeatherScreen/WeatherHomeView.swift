//
//  WeatherHomeView.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import SwiftUI

struct WeatherHomeView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ScrollView {
            ZStack {
                WeatherBackgroundView()
                VStack {
                    WeatherSearchView(viewModel: viewModel)
                    if !viewModel.isSearching {
                        if viewModel.weather != nil {
                            WeatherHeaderView(viewModel: viewModel)
                            //WeatherHourlyView(weather: viewModel.weather ?? MockWeatherData.sampleWeatherData)
                            WeatherInDetailView(viewModel: viewModel)
                        } else if let errorMessage = viewModel.errorMessage {
                            Text("Error: \(errorMessage)") // Show error message if fetching fails
                        } else {
                            Text("Enter a city to get weather data") // Placeholder when no data is available
                        }
                    }
                }
                .padding()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: Constants.Colors.gradientAPP),
                    startPoint: .topLeading, endPoint: .bottomTrailing))
            .onAppear {
                viewModel.requestLocationAccess()
            }
            .onChange(of: viewModel.searchText) { newValue in
                if !newValue.isEmpty {
                    viewModel.isSearching = true
                    viewModel.fetchCitySuggestions(for: newValue)
                } else {
                    viewModel.isSearching = false
                    viewModel.citySuggestions = []
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    // Helper function to hide the keyboard after selecting a city
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct WeatherHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHomeView(viewModel: WeatherViewModel.mock)
    }
}


