//
//  WeatherDiaryInteractor.swift
//  Weather
//
//  Created by Байсангур on 19.04.2023.
//

import Foundation
import UIKit

protocol IWeatherDiaryInteractor {
    func fetchForecastData(_ completion: @escaping ([WeatherDiaryEntity]) -> ())
    func fetchForecastInageData(url: String?,_ completion: @escaping (Data) -> ())
}

final class WeatherDiaryInteractor {
    private var weatherNetworkService: INetworkService
    
    init(weatherNetworkService: INetworkService) {
        self.weatherNetworkService = weatherNetworkService
    }
}


extension WeatherDiaryInteractor: IWeatherDiaryInteractor {
    func fetchForecastInageData(url: String?,_ completion: @escaping (Data) -> ()) {
        guard let url = url else { return }
        self.weatherNetworkService.loadCurrentWeatherImage(urlString: url) { (result: Result<Data, Error> ) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
    func fetchForecastData(_ completion: @escaping ([WeatherDiaryEntity]) -> ()) {
        var entity = [WeatherDiaryEntity]()
        self.weatherNetworkService.loadForecastWeatherData{ (result: Result<ForecastWeatherDTO, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    data.forecast.forecastday.forEach { separateDay in
                        entity.append(WeatherDiaryEntity(town: data.location.name,
                                                         date: self.remuveDate(initialDate: separateDay.date),
                                                         weatherImage: separateDay.day.condition.icon.rawValue,
                                                         temperature: self.convertTemperature(temperature:              separateDay.day.avgtempC)))
                    }
                    completion(entity)
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
}

private extension WeatherDiaryInteractor {
    
    func convertTemperature(temperature: Double) -> String {
        return String(Int(temperature)) + "°"
    }
    
    func remuveDate(initialDate: String) -> String {
        let characters = Array(initialDate)
        return String(characters[5...characters.count - 1])
    }
    
}
