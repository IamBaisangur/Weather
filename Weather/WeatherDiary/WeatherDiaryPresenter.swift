//
//  WeatherDiaryPresenter.swift
//  Weather
//
//  Created by Байсангур on 19.04.2023.
//

import Foundation

protocol IWeatherDiaryPresenter: AnyObject {
    func viewDidload(gui: IWeatherDiaryView)
    func routeToNewNote()
}

final class WeatherDiaryPresenter {
    private var gui: IWeatherDiaryView?
//    private weak var view: WeatherDiaryViewInput?
    private var interactor: IWeatherDiaryInteractor?
    private var router: IWeatherDiaryRouter?
    private var delegate = WeatherDiaryDelegate()
    private var imagesData = [Data]()
 
    init(interactor: IWeatherDiaryInteractor, router: IWeatherDiaryRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension WeatherDiaryPresenter: IWeatherDiaryPresenter {
    
    func viewDidload(gui: IWeatherDiaryView) {
        
        self.gui = gui
        self.loadForecastData()

        delegate.delegate = { [weak self] index in
            guard let self = self else { return }
            self.router?.routeToEditNote(forIndexPath: index)
        }
            
    }
    
    func routeToNewNote() {
        router?.routeToNewNote()
    }
    
    func routeToEditNote(forIndexPath: Int) {
        router?.routeToEditNote(forIndexPath: forIndexPath)
    }
}

private extension WeatherDiaryPresenter {
    
    func loadForecastData() {
        self.interactor?.fetchForecastData { [weak self] result in
            self?.loadForecastImage(forecastData: result)
            //print(result)
        }
    }
    
    func loadForecastImage(forecastData: [WeatherDiaryEntity]) {
        var arrURL = [String]()
        forecastData.forEach { day in
            arrURL.append(day.weatherImage)
        }
        
        self.loadForecastImageData(forecastData: forecastData, imagesURL: arrURL)
    }
    
    func loadForecastImageData(forecastData: [WeatherDiaryEntity], imagesURL: [String]) {
        imagesURL.forEach { url in
            self.imagesData.append(Data())
        }
        
        for urlIndex in 0 ..< imagesURL.count {
            let url = imagesURL[urlIndex]
            self.interactor?.fetchForecastImageData(urlImage: url) { [weak self] result in
                self?.imagesData[urlIndex] = result
                self?.gui?.getData(data: forecastData, imageData: self?.imagesData)
            }
        }
        
    }
}
