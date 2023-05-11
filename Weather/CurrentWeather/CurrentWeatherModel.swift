//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Байсангур on 16.03.2023.
//
import Foundation

struct CurrentWeatherModel {
    let date: String
    let temp: String
    var weatherType: Data?
    let wind: String
    let humidity: String
}

extension CurrentWeatherModel {
    init(from dtoModel: WeatherDTO) {
        guard
            let tempC = dtoModel.current?.tempC,
            let wind = dtoModel.current?.windKph,
            let humidity = dtoModel.current?.humidity else { assert(false) }
    
        self.date = Self.convertDate(date: Date.now)
        self.weatherType = nil
        self.temp = String(tempC)
        self.wind = String(wind)
        self.humidity = String(humidity)
    }
}

private extension CurrentWeatherModel {
    static func convertDate(date: Date) -> String {
        return DateConverter.showDayWithWeekDay(date)
    }
}
