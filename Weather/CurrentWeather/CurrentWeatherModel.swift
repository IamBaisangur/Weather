//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Байсангур on 16.03.2023.
//

import class UIKit.UIImage

struct CurrentWeatherModel {
    let date: String
    let temp: String
    let weatherType: WeatherType
    let wind: String
    let humidity: String
}

extension CurrentWeatherModel {
    init() {
        self.date = "16 March" //Date.now.description
        self.temp = "3"
        self.weatherType = .sunny
        self.wind = "10" + " km/h"
        self.humidity = "45" + " %"
    }
}

enum WeatherType {
    case sunny
    case rain
    case snow
    
    var description: String {
        switch self {
            
        case .sunny:
            return "sunny"
        case .rain:
            return "rain"
        case .snow:
            return "snow"
        }
    }
    
    var image: UIImage? {
        switch self {
            
        case .sunny, .snow:
            return UIImage(named: self.description)
        case .rain:
            return UIImage(named: "showers")
        }
    }
}
