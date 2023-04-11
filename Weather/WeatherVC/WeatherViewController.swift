//
//  ViewController.swift
//  Weather
//
//  Created by Байсангур on 14.03.2023.
//

import UIKit

final class WeatherViewController: UIViewController {
   
    private var gui = CustomWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.gui
        
        self.gui.setupWeatherData(WeatherViewModel())
        self.gui.actionHandler = {
            self.onNewNoteButtonPressed()
        }
        
    }
    
    private func onNewNoteButtonPressed() {
        let weatherNoteViewController = WeatherNoteViewController()
        self.navigationController?.pushViewController(weatherNoteViewController, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
    }

}
