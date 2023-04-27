//
//  WeatherDiaryDelegate.swift
//  Weather
//
//  Created by Байсангур on 26.04.2023.
//

import Foundation
import UIKit

final class WeatherDiaryDelegate: NSObject {
    var delegate: ((Int) -> ())?
}

extension WeatherDiaryDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
