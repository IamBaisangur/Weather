//
//  Endpoints.swift
//  Weather
//
//  Created by Байсангур on 30.05.2023.
//

import Foundation

enum Endpoints {
    static let currentWeatherUrlString = "https://api.weatherapi.com/v1/current.json?key=28a8f4418cb14579aad111556230305&q=London&aqi=yes"
    static let forecastWeatherUrlString = "https://api.weatherapi.com/v1/forecast.json?key=28a8f4418cb14579aad111556230305&q=Moscow&days=7&aqi=no&alerts=no"
    
    case currentWeather(city: String)
    case forecastWeather(city: String)
    
    var path: String {
        switch self {
        case let .currentWeather(city):
            return "https://api.weatherapi.com/v1/current.json?key=28a8f4418cb14579aad111556230305&q=\(city)&aqi=yes"

        case let .forecastWeather(city):
            return "https://api.weatherapi.com/v1/forecast.json?key=28a8f4418cb14579aad111556230305&q=\(city)&days=7&aqi=no&alerts=no"
        }
    }

    var url: URL? {
        URL(string: path)
    }
    
    var request: URLRequest? {
        guard let url = URL(string: path) else { return nil }
        return URLRequest(url: url)
    }
}

//        var version {
//            switch self {
//            case .weather:
//                "v1"
//            case .forecasts:
//                "v1"
//            }
//        }
