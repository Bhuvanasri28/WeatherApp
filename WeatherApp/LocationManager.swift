//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 9/12/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocationPermission() {
        manager.requestWhenInUseAuthorization() // Request location permissions
        manager.requestLocation() // Fetch location
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first?.coordinate
        self.isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error fetching location: \(error.localizedDescription)")
        self.isLoading = false
    }
}
