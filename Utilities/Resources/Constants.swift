//
//  Constants.swift
//  WeatherApp
//
//  Created by Bhuvana Ravuri on 11/04/24.
//

import SwiftUI

class Constants {
    
    class Dimensions {
        static let firstSpacing: CGFloat = 5
        static let secondSpacing: CGFloat = 10
        static let defaultPadding: CGFloat = 20
        static let cornerRadius: CGFloat = 20
        static let defaultWidth: CGFloat = 30
        static let defaultHeight: CGFloat = 30
    }
    
    class Strings {
        static let city = "Atlanta"
        static let keyAPI = "1dcc5f1ac475526107abeea81e5bf2b7"
        static let url = "https://api.openweathermap.org/data/2.5"
        static let windSpeed = "Wind speed"
        static let humidity = "Humidity"
        static let rainChances = "Rain chances"
        static let weather = "Weather"
        static let newYork = "New York"
        static let visibility = "Visibility"
    }
    
    class Colors {
        static let appUpMainColor = SwiftUI.Color(red: 180 / 255, green: 214 / 255, blue: 238 / 255)
        static let appDownMainColor = SwiftUI.Color(red: 121 / 255, green: 231 / 255, blue: 209 / 255)
        static let lightBlueColor = SwiftUI.Color(red: 87 / 255, green: 209 / 255, blue: 240 / 255)
        static let meduimBlueColor = SwiftUI.Color(red: 59 / 255, green: 164 / 255, blue: 237 / 255)
        static let darkBlueColor = SwiftUI.Color(red: 17 / 255, green: 74 / 255, blue: 170 / 255)
        static let gradient = [lightBlueColor.opacity(0.5), darkBlueColor.opacity(0.5)]
        static let gradientAPP = [appUpMainColor, appDownMainColor]
        static let gradientSerchMenu = [appUpMainColor.opacity(0.5), appDownMainColor.opacity(0.5)]
    }
    
    class Images {
        static let humidity = "humidity"
        static let wind = "wind"
        static let umbrella = "umbrella"
        static let cold = "cold"
        static let warm = "warm"
        static let magnifyingGlass = "magnifyingglass"
        static let location = "location.fill"
        static let visibility = "visibility" 
    }
    
    class Font {
        static let smallSize: CGFloat = 16
        static let mediumSize: CGFloat = 30
        static let largeSize: CGFloat = 45
    }

}

extension String {
    func localizated() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localization",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
