//
//  WeatherDiaryRouter.swift
//  Weather
//
//  Created by Байсангур on 26.04.2023.
//

import Foundation
import UIKit

protocol IWeatherDiaryRouter {
    func routeToEditNote(forIndexPath: Int)
    func routeToNewNote()
}

final class WeatherDiaryRouter {
    weak var vc: UIViewController?
}

extension WeatherDiaryRouter: IWeatherDiaryRouter {
    
    func routeToNewNote() {
        let newNoteViewController = WeatherNoteViewControllerAssembly.build()
        self.vc?.navigationController?.pushViewController(newNoteViewController, animated: true)
        self.vc?.navigationController?.navigationBar.tintColor = .white
    }
    
    func routeToEditNote(forIndexPath: Int) {
        let weatherNoteViewController = WeatherNoteViewControllerAssembly.build()
        self.vc?.present(weatherNoteViewController, animated: true)
    }
}
