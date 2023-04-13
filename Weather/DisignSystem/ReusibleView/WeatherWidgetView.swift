//
//  WeatherWidgetView.swift
//  Weather
//
//  Created by Байсангур on 15.03.2023.
//

import Foundation
import UIKit

final class WeatherWidgetView: UIView {
    
    private enum Constraints {
        static let dateLabelTopInset = CGFloat(17)
        static let heightDestribeLabel = CGFloat(30)
        static let sepHorizontalInset = CGFloat(47)
        static let humViewTopInset = CGFloat(5)
        static let humViewBottomInset = CGFloat(25)
    }
    
    private enum Constants {
        static let cornerRadius = CGFloat(16)
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = AppFonts.regular18.font
        label.text = "-"
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = AppFonts.regular50.font
        label.text = "-"
        return label
    }()
    private let weatherDestribeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = AppFonts.bold20.font
        label.text = "-"
        return label
    }()
    
    private let windView = SectionSeparatorView(type: .wind)
    private let humView = SectionSeparatorView(type: .humidity)
    
    init() {
        super.init(frame: .zero)
        self.setupLayout()
        self.configureWidgetView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Данные с сервера
    func setupWeatherData(_ modelData: CurrentWeatherModel) {
        self.dateLabel.text = modelData.date
        self.temperatureLabel.text = modelData.temp + "°"
        self.weatherDestribeLabel.text = modelData.weatherType.description
        
        self.windView.setupData(modelData.wind)
        self.humView.setupData(modelData.humidity)
        
//        self.windView.imageView.image = UIImage(named: "windy")
//        self.windView.nameLabel.text = "wind"
//        self.windView.dataLabel.text = vm.wind + " km/h"
//
//        self.humView.imageView.image = UIImage(named: "hum")
//        self.humView.nameLabel.text = "hum"
//        self.humView.dataLabel.text = vm.humidity + " %"
        
    }
}

private extension WeatherWidgetView {
    
    private func configureWidgetView() {
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupLayout() {
        self.addSubview(self.dateLabel)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.dateLabelTopInset),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.addSubview(self.temperatureLabel)
        self.temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.temperatureLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor),
            self.temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        self.addSubview(self.weatherDestribeLabel)
        self.weatherDestribeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weatherDestribeLabel.topAnchor.constraint(equalTo: self.temperatureLabel.bottomAnchor),
            //self.weatherDestribeLabel.heightAnchor.constraint(equalToConstant: Constraints.heightDestribeLabel),
            self.weatherDestribeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.weatherDestribeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        self.addSubview(self.windView)
        self.windView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.windView.topAnchor.constraint(equalTo: self.weatherDestribeLabel.bottomAnchor),
            self.windView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            //self.windView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraints.sepHorizontalInset),
            //self.windView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraints.sepHorizontalInset)
        ])
        
        self.addSubview(self.humView)
        self.humView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.humView.topAnchor.constraint(equalTo: self.windView.bottomAnchor, constant: Constraints.humViewTopInset),
            self.humView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constraints.humViewBottomInset),
            self.humView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//            self.humView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraints.sepHorizontalInset),
//            self.humView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraints.sepHorizontalInset)
        ])
    }
    
}
