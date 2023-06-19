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
    
    private weak var gui: ICustomWeatherView?
    private let weatherNetworkService: INetworkService

    init(weatherNetworkService: INetworkService) {
        self.weatherNetworkService = weatherNetworkService
    }
    
    func viewDidLoad(gui: ICustomWeatherView) {
        self.gui = gui
        self.fetchDataFromNetworkService()
    }
}

private extension CurrentWeatherPresenter {
    func fetchDataFromNetworkService() {
        self.weatherNetworkService.getCurrentWeatherData(
            city: "Moscow") { result in
                switch result {
                case let .success(model):
                    DispatchQueue.main.async {
                        let currentWeatherModel = CurrentWeatherModel(from: model)
                        self.gui?.setupWeatherData(currentWeatherModel)
                        self.getImageDataFromURL(url: model.current?.condition?.icon)
                    }

                case let .failure(error):
                    DispatchQueue.main.async {
                        print("Presenter: \(error.localizedDescription)")
                    }
                }
            }
    }
    
    func getImageDataFromURL(url: String?) {
        guard let url = url else { return }
        self.weatherNetworkService.loadCurrentWeatherImage(urlString: url) { (result: Result<Data, Error> ) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.gui?.setImage(imageData: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
}
