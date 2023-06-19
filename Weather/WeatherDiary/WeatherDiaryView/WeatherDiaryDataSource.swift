//
//  WeatherDiaryDataSource.swift
//  Weather
//
//  Created by Байсангур on 25.04.2023.
//

import Foundation
import UIKit

final class WeatherDiaryDataSource: NSObject {
    
    var data = [WeatherDiaryEntity]()
    var imageData: [Data]?
}

extension WeatherDiaryDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherNoteCell.identifier, for: indexPath) as? WeatherNoteCell else { return UITableViewCell()}
        cell.displayData(entity: self.data[indexPath.row], imageData: self.imageData?[indexPath.row])
        return cell
    }
}
