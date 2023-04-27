//
//  WeatherDiaryInteractor.swift
//  Weather
//
//  Created by Байсангур on 19.04.2023.
//

import Foundation

protocol IWeatherDiaryInteractor {
    func generateData() -> [WeatherDiaryEntity]
}

final class WeatherDiaryInteractor {
    
}

extension WeatherDiaryInteractor: IWeatherDiaryInteractor {
    
    func generateData() -> [WeatherDiaryEntity] {
        var entity = [WeatherDiaryEntity]()
        for _ in 0...10 {
            entity.append(WeatherDiaryEntity(town: self.randomCity(),
                                             date: "20 april",
                                             weatherImage: WeatherType.sunny,
                                             temperature: self.randomTemperature()))
        }
        return entity
    }
}

private extension WeatherDiaryInteractor {
    func randomCity() -> String {
        return ["Novosibirsk", "Tomsk", "St.Petersburg"].randomElement() ?? "Moscow"
    }
    
    func randomTemperature() -> String {
        let randomInt = Int.random(in: 0...30)
        return String(randomInt) + "°"
    }
}
