//
//  NetworkService.swift
//  Weather
//
//  Created by Байсангур on 03.05.2023.
//

import Foundation
import UIKit

protocol INetworkService: AnyObject {
    func loadCurrentWeatherData<T:Codable>(completion: @escaping(Result<T, Error>) -> ())
}

final class NetworkService {
    enum Endpoints {
        static let currentWeatherUrlString = "https://api.weatherapi.com/v1/current.json?key=28a8f4418cb14579aad111556230305&q=London&aqi=yes"
    }
}

extension NetworkService: INetworkService {
    func loadCurrentWeatherData<T:Codable>(completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: Endpoints.currentWeatherUrlString) else { assert(false)}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            print(data)
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
}
