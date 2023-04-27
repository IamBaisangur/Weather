//
//  WeatherType.swift
//  Weather
//
//  Created by Байсангур on 19.04.2023.
//

import Foundation

import class UIKit.UIImage

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
