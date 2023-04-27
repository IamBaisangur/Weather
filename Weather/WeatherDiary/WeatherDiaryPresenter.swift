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
        let data = self.interactor?.generateData()
        self.gui = gui
        if let data = data {
            self.gui?.getData(data: data)
        }
        
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
