////
////  WeatherSearchView.swift
////  WeatherApp
////
////  Created by Bhuvana Ravuri on 11/5/24.
////
//
//import SwiftUI
//
//struct WeatherSearchView: View {
//    
//    @ObservedObject var viewModel: WeatherViewModel
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            VStack {
//                Text("\(Constants.Strings.weather)")
//                    .bold()
//                    .foregroundColor(.white)
//                    .font(.largeTitle)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 10)
//                    .padding(.top, 60)
//                
//                SearchBar(text: $viewModel.searchText) // Bind directly to viewModel.searchText
//                    .padding(.bottom, 0)
//                    .foregroundColor(.clear)
//                
//                // Display the list of filtered city suggestions
//                if !viewModel.searchText.isEmpty {
//                    ScrollView {
//                        VStack {
//                            ForEach(viewModel.citySuggestions) { city in
//                                Text("\(city.name), \(city.state ?? ""), \(city.country)")
//                                    .onTapGesture {
//                                        viewModel.searchText = city.name
//                                        viewModel.fetchWeather(for: city.name)
//                                        hideKeyboard()
//                                        viewModel.isSearching = false
//                                        viewModel.searchText = ""
//                                    }
//                            }
//                        }
//                        .frame(maxHeight: 200) // Adjust the height based on your design
//                    }
//                }
//            }
//        }
//    }
//    
//    // Helper function to hide the keyboard after selecting a city
//    private func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//
//#Preview {
//    WeatherSearchView(viewModel: WeatherViewModel.mock)
//}
