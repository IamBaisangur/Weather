//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Байсангур on 16.03.2023.
//

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
