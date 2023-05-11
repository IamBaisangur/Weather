//
//  WeatherModel.swift
//  Weather
//
//  Created by Байсангур on 03.05.2023.
//

import Foundation

// MARK: - WeatherModel
struct WeatherDTO: Codable {
    let current: Current?
}

// MARK: - Current
struct Current: Codable {

    let tempC: Int?
    let condition: Condition?
    let windKph: Double?
    let humidity: Int?


    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
        case humidity
    }
}

// MARK: - Condition
struct Condition: Codable {
    let icon: String?
}

