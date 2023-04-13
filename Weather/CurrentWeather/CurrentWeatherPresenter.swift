//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Байсангур on 11.04.2023.
//

import Foundation

// Interface
protocol ICurrentWeatherPresenter: AnyObject {
    func viewDidLoad(gui: ICustomWeatherView)
}

final class CurrentWeatherPresenter: ICurrentWeatherPresenter {
    
    weak var gui: ICustomWeatherView?
    let model: CurrentWeatherModel
    
    init(model: CurrentWeatherModel){
        self.model = model
    }
    
    func viewDidLoad(gui: ICustomWeatherView) {
        self.gui = gui
        self.gui?.setupWeatherData(self.model)
//        self.gui?.tapButtonHandler = {
//            print("Open WeatherNoteViewController")
//        }
    }
    
}
