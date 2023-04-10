//
//  SectionSeparatorView.swift
//  Weather
//
//  Created by Байсангур on 15.03.2023.
//

import UIKit

final class SectionSeparatorView: UIView {
    enum WeatherParameters {
        case wind
        case humidity
        
        var description: String {
            switch self {
            case .wind:
                return "Wind"
            case .humidity:
                return "Hum"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .wind:
                return UIImage(named: "windy")
            case .humidity:
                return UIImage(named: "hum")
            }
        }
    }
    
    private enum Constraints {
        static let verticalInset = CGFloat(5)
        static let insetToSeparator = CGFloat(5)
        static let imageViewSize = CGSize(width: 20, height: 20)
    }
    
    let imageView = UIImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .white
        label.font = AppFonts.regular20.font
        return label
    }()
    
    private let separatorLabel: UILabel = {
        let separator = UILabel()
        separator.textAlignment = .center
        separator.text = "|"
        separator.textColor = .white
        separator.font = AppFonts.regular18.font
        return separator
    }()
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.font = AppFonts.regular20.font
        return label
    }()

    init(type: WeatherParameters) {
        super.init(frame: .zero)
        self.configureView(with: type)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionSeparatorView {
    private func configureView(with type: WeatherParameters) {
        self.imageView.image = type.image
        self.nameLabel.text = type.description
//        switch type {
//        case .wind:
//            self.imageView.image = UIImage(named: "windy")
//            self.nameLabel.text = "Wind"
//        case .humidity:
//            self.imageView.image = UIImage(named: "hum")
//            self.nameLabel.text = "Hum"
//        }
    }
    
    private func setupLayout() {
        self.addSubview(self.imageView)
        self.imageView.sizeThatFits(Constraints.imageViewSize) // ?
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.verticalInset),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constraints.verticalInset),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)])

        
        self.addSubview(self.separatorLabel)
        self.separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.separatorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.verticalInset),
            self.separatorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constraints.verticalInset),
            self.separatorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
        
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.verticalInset),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constraints.verticalInset),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.separatorLabel.leadingAnchor, constant: -Constraints.insetToSeparator)])
        
        self.addSubview(self.dataLabel)
        self.dataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dataLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.verticalInset),
            self.dataLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constraints.verticalInset),
            self.dataLabel.leadingAnchor.constraint(equalTo: self.separatorLabel.trailingAnchor, constant: Constraints.insetToSeparator),
            self.dataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
    }
    
    func setupData(_ value: String) {
        self.dataLabel.text = value
        //self.imageView.image = UIImage(named: "windy")
    }
    
}

