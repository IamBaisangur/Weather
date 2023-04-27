//
//  WeatherDiaryAssembly.swift
//  Weather
//
//  Created by Байсангур on 22.03.2023.
//

import Foundation

enum WeatherDiaryAssembly {
    static func build() -> WeatherDiaryViewController {
        
        let router = WeatherDiaryRouter()
        let interactor = WeatherDiaryInteractor()
        let presenter = WeatherDiaryPresenter(interactor: interactor, router: router)
        let vc = WeatherDiaryViewController(presenter: presenter)
        return vc
    }
}
