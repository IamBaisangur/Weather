//
//  WeatherDiary.swift
//  Weather
//
//  Created by Байсангур on 22.03.2023.
//

import Foundation
import UIKit

//protocol WeatherDiaryViewInput: AnyObject {
//    func display(weatherViewModel: CurrentWeatherModel)
//}
//
//protocol WeatherDiaryViewOutput {
//    
//}

final class WeatherDiaryViewController: UIViewController {
    
    private var presenter: IWeatherDiaryPresenter?
    private let gui = WeatherDiaryView()
    
    init(presenter: IWeatherDiaryPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.gui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        presenter?.viewDidload(gui: self.gui)
    }

//    func display(weatherViewModel: CurrentWeatherModel) {
//        gui.getData(data: <#T##[WeatherDiaryEntity]#>)
//    }
}

private extension WeatherDiaryViewController {
    private func setupNavBar() {
        let image = UIImage(named: "edit")
        let navBarItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.routeToNewNote))
        navBarItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = navBarItem
    }
    
    @objc
    func routeToNewNote() {
        presenter?.routeToNewNote()
    }
}

