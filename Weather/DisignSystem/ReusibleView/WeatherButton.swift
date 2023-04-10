//
//  WeatherButton.swift
//  Weather
//
//  Created by Байсангур on 17.03.2023.
//

import Foundation
import UIKit

final class WeatherButton: UIView {
    
    private enum Constants {
        static let cornerRadius = CGFloat(16)
        static let borderWidth = CGFloat(1)
        
        static let imageViewInset = CGFloat(20)
        static let labelInset = CGFloat(20)
        static let insetImageToLabel = CGFloat(12)
    }
    
    struct Settings {
        let imageName: String?
        let labelText: String
        let font: AppFonts
        let tapHandler: () -> Void
    }
    
    private let tapHandler: () -> Void
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFonts.regular16.font
        label.textAlignment = .center
        return label
    }()
    
    init(settings: Settings) {
        self.tapHandler = settings.tapHandler
        super.init(frame: .zero)
        self.configureUI(with: settings)
        self.configureView()
        self.setupLayout(with: settings)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Конфигурация нижниго слоя

private extension WeatherButton {
    
    func configureView() {
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = Constants.borderWidth
        self.layer.borderColor = UIColor.white.cgColor
    }
}

// MARK: - Добавление констрейнтов

private extension WeatherButton {
    
    func setupLayout(with settings: Settings) {
        if settings.imageName != nil {
            self.setupLayoutWithImageView()
        } else {
            self.setupLayoutWithoutImageView()
        }
    }

    
    func setupLayoutWithoutImageView() {
        
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.labelInset),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.labelInset),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.labelInset),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.labelInset)])
    }
    
    func setupLayoutWithImageView() {
        
        self.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.imageViewInset),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.imageViewInset),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  Constants.imageViewInset)])
        
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.labelInset),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.labelInset),
            self.label.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: Constants.insetImageToLabel),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.labelInset)])
    }
}

// MARK: - Добавление настроек

private extension WeatherButton {
    
    func configureUI(with settings: Settings) {
        if let imageName = settings.imageName {
            self.imageView.image = UIImage(named: imageName)
        }
        
        self.label.text = settings.labelText
        self.label.font = settings.font.font
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func viewTapped() {
        self.tapHandler()
    }
    
}
