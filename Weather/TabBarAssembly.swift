//
//  TabBarAssembler.swift
//  Weather
//
//  Created by Байсангур on 22.03.2023.
//

import Foundation
import UIKit

enum TabBarAssembly {
    
    static func build() -> UITabBarController {
        let tabBar = UITabBarController()
        
        let weatherViewController = CurrentWeatherAssembly.build()
        let weatherNavigationController = UINavigationController(rootViewController: weatherViewController)
        
        let weatherDiaryViewController = WeatherDiaryAssembly.build()
        let weatherDiaryNavigationController = UINavigationController(rootViewController: weatherDiaryViewController)
        
        tabBar.setViewControllers([weatherNavigationController, weatherDiaryNavigationController], animated: true)
        weatherNavigationController.tabBarItem = UITabBarItem(title: "Current weather", image: UIImage(named: "sunnyTabBarIcon"), tag: 0)
        weatherDiaryNavigationController.tabBarItem = UITabBarItem(title: "Weather diary", image: UIImage(named: "editTabBarIcon"), tag: 0)
        
        tabBar.tabBar.tintColor = .white
        tabBar.tabBar.unselectedItemTintColor = .black
        return tabBar
    }
}
