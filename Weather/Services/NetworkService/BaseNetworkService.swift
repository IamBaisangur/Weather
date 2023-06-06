//
//  BaseNetworkService.swift
//  Weather
//
//  Created by Байсангур on 29.05.2023.
//

import Foundation

protocol IBaseNetworkService {
    @discardableResult
    func execute<T: Decodable>(
        _ request: URLRequest,
        model: T.Type,
        completionHandler: @escaping (_ result: T?, _ response: HTTPURLResponse?, _ error: Error?) -> ()
    ) -> String
}

class BaseNetworkService: IBaseNetworkService {
    let worker: INetworkWorker
    
    init(worker: INetworkWorker = NetworkWorker()) {
        self.worker = worker
    }
    
    @discardableResult
    func execute<T: Decodable>(
        _ request: URLRequest,
        model: T.Type,
        completionHandler: @escaping (_ result: T?, _ response: HTTPURLResponse?, _ error: Error?) -> ()
    ) -> String {
            self.worker.execute(request) { data, response, error in
                guard let data = data else { return }
                
                do {
                    let newData = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(newData, response, nil)
                }
                catch let error {
                    completionHandler(nil, response, error)
                }
            }
    }
}
