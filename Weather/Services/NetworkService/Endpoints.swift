//
//  Endpoints.swift
//  Weather
//
//  Created by Байсангур on 30.05.2023.
//

import Foundation

enum Endpoints {
    static let currentWeatherUrlString = "https://api.weatherapi.com/v1/current.json?key=28a8f4418cb14579aad111556230305&q=London&aqi=yes"
    static let forecastWeatherUrlString = "https://api.weatherapi.com/v1/forecast.json?key=28a8f4418cb14579aad111556230305&q=London&days=7&aqi=no&alerts=no"
    
    case weather(country: String)
    case forecasts
    
    var path: String {
        switch self {
        case let .weather(counrty):
            return "https://api.weatherapi.com/v1/current.json?key=28a8f4418cb14579aad111556230305&q=\(counrty)&aqi=yes"

        case .forecasts:
            return "https://api.weatherapi.com/v1/forecast.json?key=28a8f4418cb14579aad111556230305&q=London&days=7&aqi=no&alerts=no"
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
