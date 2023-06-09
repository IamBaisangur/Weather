//
//  WeatherDiaryModel.swift
//  Weather
//
//  Created by Байсангур on 19.04.2023.
//

import Foundation

struct WeatherDiaryEntity {
    let town: String
    let date: String
    let weatherImage: String
    let temperature: String
}

extension WeatherDiaryEntity {
    init(town: String, weatherImage: String, date: String, temperature: String) {
        self.town = town
        self.weatherImage = weatherImage
        self.date = date
        self.temperature = temperature
    }
}
