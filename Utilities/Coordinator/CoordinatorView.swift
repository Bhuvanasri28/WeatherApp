//
//  CoordinatorView.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import SwiftUI

struct CoordinatorView: UIViewControllerRepresentable {
    @ObservedObject var coordinator: MainCoordinator

    func makeUIViewController(context: Context) -> UINavigationController {
        coordinator.start()
        return coordinator.navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // No-op
    }
}
