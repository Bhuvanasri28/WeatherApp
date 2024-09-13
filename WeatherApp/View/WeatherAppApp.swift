//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 9/12/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject private var coordinator = MainCoordinator(navigationController: UINavigationController())  // Correct initialization

    var body: some Scene {
        WindowGroup {
            NavigationView {
                CoordinatorView(coordinator: coordinator)  // Use CoordinatorView to bridge SwiftUI and UIKit
            }
        }
    }
}

