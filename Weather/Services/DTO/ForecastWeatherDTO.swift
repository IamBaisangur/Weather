//
//  ForecastWeatherDTO.swift
//  Weather
//
//  Created by Байсангур on 15.05.2023.
//

import Foundation

// MARK: - ForecastWeatherModel
struct ForecastWeatherDTO: Codable {
    let forecast: Forecast
    let location: Location
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let day: Day

    enum CodingKeys: String, CodingKey {
        case date
        case day
    }
}

// MARK: - Day
struct Day: Codable {
    let avgtempC: Double
    let condition: ConditionForecast

    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
        case condition
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

//MARK: - Condition
struct ConditionForecast: Codable {
    let icon: Icon
    
    enum CodingKeys: String, CodingKey {
        case icon = "icon"
    }

}

enum Icon: String, Codable {
    case cdnWeatherapiCOMWeather64X64Day113PNG = "//cdn.weatherapi.com/weather/64x64/day/113.png"
    case cdnWeatherapiCOMWeather64X64Day116PNG = "//cdn.weatherapi.com/weather/64x64/day/116.png"
    case cdnWeatherapiCOMWeather64X64Day119PNG = "//cdn.weatherapi.com/weather/64x64/day/119.png"
    case cdnWeatherapiCOMWeather64X64Day122PNG = "//cdn.weatherapi.com/weather/64x64/day/122.png"
    case cdnWeatherapiCOMWeather64X64Night113PNG = "//cdn.weatherapi.com/weather/64x64/night/113.png"
    case cdnWeatherapiCOMWeather64X64Night116PNG = "//cdn.weatherapi.com/weather/64x64/night/116.png"
    case cdnWeatherapiCOMWeather64X64Night119PNG = "//cdn.weatherapi.com/weather/64x64/night/119.png"
    case cdnWeatherapiCOMWeather64X64Night122PNG = "//cdn.weatherapi.com/weather/64x64/night/122.png"
}
