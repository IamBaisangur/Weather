//
//  ViewController.swift
//  Weather
//
//  Created by Байсангур on 14.03.2023.
//

import UIKit

final class WeatherViewController: UIViewController {
   
    var gui = CustomWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gui.setupWeatherData(WeatherViewModel())
    }
    
    private func onNewNoteButtonPressed() {
        let weatherNoteViewController = WeatherNoteViewController()
        self.navigationController?.pushViewController(weatherNoteViewController, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
    }

}

