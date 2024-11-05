//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import UIKit
import SwiftUI

protocol Coordinator {
    func start()
}

class MainCoordinator: NSObject, ObservableObject, Coordinator {  // Conform to ObservableObject
    var navigationController: UINavigationController

    // Initialize with UINavigationController
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = WeatherViewModel()
        let contentView = WeatherHomeView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: contentView)
        navigationController.pushViewController(hostingController, animated: true)
    }
}

