//
//  WeatherAssembly.swift
//  Weather
//
//  Created by Байсангур on 22.03.2023.
//

import Foundation

enum CurrentWeatherAssembly {
    static func build() -> CurrentWeatherViewController {
        let presenter = CurrentWeatherPresenter()
        let vc = CurrentWeatherViewController(presenter: presenter)
        return vc
    }
}
