//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 9/12/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false // Add this state to control searching state
    
    var body: some View {
        
        ZStack{
            VStack {
                VStack {
                    Text("\(Constants.Strings.weather)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                    
                    // Add the SearchBar at the top
                    SearchBar(text: $searchText)
                        .padding(.bottom, 0)
                        .foregroundColor(.clear)
                    
                    // Display the list of filtered city suggestions
                    if !searchText.isEmpty {
                        List {
                            ForEach(viewModel.citySuggestions) { city in
                                Text("\(city.name), \(city.state ?? ""), \(city.country)")
                                    .onTapGesture {
                                        searchText = city.name
                                        viewModel.fetchWeather(for: city.name)
                                        hideKeyboard() // Hide the keyboard after selection
                                        isSearching = false // Set searching state to false
                                        searchText = "" // Clear the search text
                                    }
                            }
                        }
                        .frame(height: 200) // Adjust the height based on your design
                    }
                }
                
                // Display weather details here only if not searching
                if !isSearching {
                    if let weather = viewModel.weather {
                        WeatherDetailsView(weather: weather, weatherViewModel: viewModel) // Show weather details if fetched
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)") // Show error message if fetching fails
                    } else {
                        Text("Enter a city to get weather data") // Placeholder when no data is available
                    }
                }
                Spacer()
            }
        }.background(
            LinearGradient(
                gradient: Gradient(colors: Constants.Colors.gradientAPP),
                startPoint: .topLeading, endPoint: .bottomTrailing))
        .onAppear {
            viewModel.fetchWeather(for: Constants.Strings.newYork)  // Default city
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
    
    // Helper function to hide the keyboard after selecting a city
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


