//
//  AppFonts.swift
//  Weather
//
//  Created by Байсангур on 14.03.2023.
//

import Foundation
import UIKit

enum AppFonts {
    case regular50
    case regular20
    case regular18
    case regular16
    case bold20
    case bold24
    case bold28
    
    var font: UIFont? {
        switch self {
        case .regular50:
            return UIFont(name: "Overpass-Regular", size: 50)
        case .regular20:
            return UIFont(name: "Overpass-Regular", size: 20)
        case .regular18:
            return UIFont(name: "Overpass-Regular", size: 18)
        case .regular16:
            return UIFont(name: "Overpass-Regular", size: 16)
        case .bold20:
            return UIFont(name: "Overpass-Bold", size: 20)
        case .bold24:
            return UIFont(name: "Overpass-Bold", size: 24)
        case .bold28:
            return UIFont(name: "Overpass-Bold", size: 28)
        }
    }
}
