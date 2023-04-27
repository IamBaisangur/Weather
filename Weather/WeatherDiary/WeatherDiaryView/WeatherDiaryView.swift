//
//  WeatherDiaryView.swift
//  Weather
//
//  Created by Байсангур on 13.04.2023.
//

import Foundation
import UIKit

protocol IWeatherDiaryView: AnyObject {
    func getData(data: [WeatherDiaryEntity])
}

final class WeatherDiaryView: UIView {
    
    private let tableView = UITableView()
    public var data: [WeatherDiaryEntity]?
    
    let dataSource = WeatherDiaryDataSource()
    let delegate = WeatherDiaryDelegate()
    
    init() {
        super.init(frame: .zero)
        self.setupLayout()
        self.configureTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        let backgroundImageView = UIImageView(image: UIImage(named: "background"))
        self.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        self.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    func configureTable() {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear //UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        self.tableView.register(WeatherNoteCell.self, forCellReuseIdentifier: WeatherNoteCell.identifier )
    }
    

}

extension WeatherDiaryView: IWeatherDiaryView {
    
    func getData(data: [WeatherDiaryEntity]) {
        self.dataSource.data = data
        self.tableView.reloadData()
    }
}
