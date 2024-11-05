//
//  WeatherHomeView.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import SwiftUI

struct WeatherHomeView: View {
    
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ScrollView {
            ZStack {
                WeatherBackgroundView()
                VStack(spacing: 20) {
                    VStack {
                        Text("\(Constants.Strings.weather)")
                            .bold()
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                            .padding(.top, 60)
                        
                        SearchBar(text: $searchText)
                            .padding(.bottom, 0)
                            .foregroundColor(.clear)
                        
                        // Display the list of filtered city suggestions
                        if !searchText.isEmpty {
                            ScrollView {
                                VStack {
                                    ForEach(viewModel.citySuggestions) { city in
                                        Text("\(city.name), \(city.state ?? ""), \(city.country)")
                                            .onTapGesture {
                                                searchText = city.name
                                                viewModel.fetchWeather(for: city.name)
                                                hideKeyboard()
                                                isSearching = false
                                                searchText = ""
                                            }
                                    }
                                }
                                .frame(maxHeight: 200) // Adjust the height based on your design
                            }
                        }
                    }
                    if !isSearching {
                        if let weather = viewModel.weather {
                            WeatherHeaderView(viewModel: viewModel)
                            //WeatherHourlyView(weather: viewModel.weather ?? MockWeatherData.sampleWeatherData)
                            WeatherInDetailView(viewModel: viewModel)
                        } else if let errorMessage = viewModel.errorMessage {
                            Text("Error: \(errorMessage)") // Show error message if fetching fails
                        } else {
                            Text("Enter a city to get weather data") // Placeholder when no data is available
                        }
                    }
                    Spacer()
                    
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
            .onChange(of: searchText) { newValue in
                if !newValue.isEmpty {
                    isSearching = true // Set searching state to true when user starts typing
                    viewModel.fetchCitySuggestions(for: newValue)
                } else {
                    isSearching = false // Set searching state to false when search text is empty
                    viewModel.citySuggestions = []  // Clear suggestions when search is empty
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


