//
//  NetworkService.swift
//  Weather
//
//  Created by Байсангур on 03.05.2023.
//

import Foundation

enum NetworkError: Error {
    case somethingWentWrong
}

protocol INetworkService: AnyObject {
    func getCurrentWeatherData(country: String, completionHandler: @escaping (Result<WeatherDTO, Error>) -> ())
}

final class WeatherNetworkService: BaseNetworkService {
    
    enum Endpoints {
        static let currentWeatherUrlString = "https://api.weatherapi.com/v1/current.json?key=28a8f4418cb14579aad111556230305&q=London&aqi=yes"
        static let forecastWeatherUrlString = "https://api.weatherapi.com/v1/forecast.json?key=28a8f4418cb14579aad111556230305&q=London&days=7&aqi=no&alerts=no"
        
        case weather(country: String)
        case forecasts
        
        var path: String {
            switch self {
            case let .weather(counrty):
                return "https://api.weatherapi.com/v1/current.json?key=28a8f4418cb14579aad111556230305&q=\(counrty)&aqi=yes"

            case .forecasts:
                return "https://api.weatherapi.com/v1/forecast.json?key=28a8f4418cb14579aad111556230305&q=London&days=7&aqi=no&alerts=no"
            }
        }
    
        var url: URL? {
            URL(string: path)
        }

//        var version {
//            switch self {
//            case .weather:
//                "v1"
//            case .forecasts:
//                "v1"
//            }
//        }
        
        var request: URLRequest? {
            guard let url = URL(string: path) else { return nil }
            return URLRequest(url: url)
        }
    }
}



extension WeatherNetworkService: INetworkService {
    func getCurrentWeatherData(country: String, completionHandler: @escaping (Result<WeatherDTO, Error>) -> Void) {
        guard let req  = Endpoints.weather(country: country).request else { completionHandler(.failure(NetworkError.somethingWentWrong))
            return
        }
        
        super.execute(req, model: WeatherDTO.self) { result, _, error in
            guard let result = result else {
                completionHandler(.failure(error ?? NetworkError.somethingWentWrong))
                return
            }
            completionHandler(.success(result))
        }
    }
    
    
    func loadCurrentWeatherData<T:Codable>(completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: Endpoints.currentWeatherUrlString) else { assert(false) }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            do {
                let newData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(newData))
            }
            catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func loadCurrentWeatherImage(urlString: String, completion: @escaping(Result<Data, Error>) -> ()) {
        let correctUrlString = "https:" + urlString
        guard let url = URL(string: correctUrlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.downloadTask(with: request) { url, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let url = url else { return }
            
            if let data = try? Data(contentsOf: url){
                completion(.success(data))
            }
        }.resume()
    }
    
    func loadForecastWeatherData<T:Codable>(completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: Endpoints.forecastWeatherUrlString) else { assert(false) }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            do {
                let newData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(newData))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
