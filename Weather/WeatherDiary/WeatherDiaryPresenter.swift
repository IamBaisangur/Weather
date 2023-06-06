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
            self?.gui?.getData(data: result)
            
            result.forEach { day in
                self?.loadForecastImageData(url: day.weatherImage)
            }
        }
    }
    
    func loadForecastImageData(url: String?) {
        self.interactor?.fetchForecastInageData(url: url) { [weak self] result in
            print(result)
            //self?.gui?.getData(data: result)
        }
    }
}
