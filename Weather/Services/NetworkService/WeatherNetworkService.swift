//
//  NetworkService.swift
//  Weather
//
//  Created by Байсангур on 03.05.2023.
//

import Foundation

protocol INetworkService: AnyObject {
    func getCurrentWeatherData(country: String, completionHandler: @escaping (Result<WeatherDTO, Error>) -> ())
    func loadCurrentWeatherImage(urlString: String, completion: @escaping(Result<Data, Error>) -> ())
    func loadForecastWeatherData<T:Codable>(completion: @escaping (Result<T, Error>) -> ())
}

final class WeatherNetworkService: BaseNetworkService {
    
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
}

extension WeatherNetworkService: INetworkService {
    
    func getCurrentWeatherData(country: String, completionHandler: @escaping (Result<WeatherDTO, Error>) -> ()) {
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
