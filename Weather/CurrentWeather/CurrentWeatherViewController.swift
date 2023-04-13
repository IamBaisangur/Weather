//
//  ViewController.swift
//  Weather
//
//  Created by Байсангур on 14.03.2023.
//

import UIKit


final class CurrentWeatherViewController: UIViewController {
   
    private var presenter: ICurrentWeatherPresenter?
    private var gui = CustomWeatherView()
    
    override func loadView() {
        self.view = self.gui
    }
    
    override func viewDidLoad( ) {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad(gui: self.gui)
        self.gui.tapButtonHandler = {
            self.onNewNoteButtonPressed()
        }
        
    }
    
    private func onNewNoteButtonPressed() {
        let weatherNoteViewController = WeatherNoteViewController()
        self.navigationController?.pushViewController(weatherNoteViewController, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    init(presenter: ICurrentWeatherPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
