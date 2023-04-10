//
//  Weather.swift
//  Weather
//
//  Created by Байсангур on 30.03.2023.
//

import Foundation
import UIKit

enum Weather: String, CaseIterable {
    
    case cloudy
    case showers
    case snow
    case sunny
    
    var image: UIImage? {
        
        switch self {
        case .cloudy:
            return UIImage(named: "cloudy")
        case .showers:
            return UIImage(named: "showers")
        case .snow:
            return UIImage(named: "snow")
        case .sunny:
            return UIImage(named: "sunny")
        }
    }
    
}
