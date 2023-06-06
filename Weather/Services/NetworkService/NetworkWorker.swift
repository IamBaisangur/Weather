//
//  NetworkWorker.swift
//  Weather
//
//  Created by Байсангур on 29.05.2023.
//

import Foundation

protocol INetworkWorker {
    func execute(
        _ request: URLRequest,
        completionHandler: @escaping (
            _ result: Data?,
            _ response: HTTPURLResponse?,
            _ error: Error?
            ) -> ()
    ) -> String
    
    func cancel(_ task: String)
}

class NetworkWorker: INetworkWorker {
    
    private var activateTasks: [String: URLSessionDataTask]
    private let urlSession: URLSession
    
    convenience init() {
        self.init(cfg: .default)
    }
    
    init(cfg: URLSessionConfiguration) {
        self.urlSession = URLSession(configuration: cfg)
        self.activateTasks = [:]
    }
    
    func execute(
        _ request: URLRequest,
        completionHandler: @escaping (
            _ result: Data?,
            _ response: HTTPURLResponse?,
            _ error: Error?
        ) -> ()
    ) -> String {
        let taskID = UUID().uuidString
        let task = urlSession.dataTask(with: request) { data, response, error in
            completionHandler(data, response as? HTTPURLResponse, error)
        }
        self.activateTasks[taskID] = task
        task.resume()
        return taskID
    }
    
    func cancel(_ task: String) {
        self.activateTasks[task]?.cancel()
    }
}

