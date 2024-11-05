//
//  WeatherBackgroundView.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/4/24.
//

import SwiftUI

struct WeatherBackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        
    }
}

#Preview {
    WeatherBackgroundView()
}
