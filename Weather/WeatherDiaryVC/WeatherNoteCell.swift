//
//  WeatherNoteCell.swift
//  Weather
//
//  Created by Байсангур on 22.03.2023.
//

import Foundation
import UIKit

final class WeatherNoteCell: UITableViewCell {
    
    private enum Constraint {
        static let topBottomInset: CGFloat = 18
        static let horisontalInset: CGFloat = 25
        static let sizeImage: CGFloat = 48
        static let leadingTrailingInset: CGFloat = 16
    }
    
    static let identifier = String(describing: WeatherNoteCell.self)
    private var safeArea: UILayoutGuide!
    let containerView = UIView()
    
    private let townLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.bold24.font
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.bold24.font
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let degreeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.bold24.font
        label.textColor = .white
        label.textAlignment = .right
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private var weatherImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sunny")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WeatherNoteCell {
    func setupLayout() {
        self.backgroundColor = .clear
        self.safeArea = layoutMarginsGuide
        self.safeArea.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive = true
        
        self.addSubview(self.containerView)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.containerView.addSubview(self.degreeLabel)
        self.degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.degreeLabel.text = "27°"
        NSLayoutConstraint.activate([
            self.degreeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.leadingTrailingInset),
            self.degreeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.containerView.addSubview(self.weatherImageView)
        self.weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        self.weatherImageView.image = UIImage(named: "sunny")
        NSLayoutConstraint.activate([
            self.weatherImageView.heightAnchor.constraint(equalToConstant: Constraint.sizeImage),
            self.weatherImageView.widthAnchor.constraint(equalToConstant: Constraint.sizeImage),
            self.weatherImageView.trailingAnchor.constraint(equalTo: self.degreeLabel.leadingAnchor, constant: -Constraint.horisontalInset),
            self.weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.containerView.addSubview(self.dateLabel)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.text = "23.03"
        NSLayoutConstraint.activate([
            self.dateLabel.trailingAnchor.constraint(equalTo: self.weatherImageView.leadingAnchor, constant: -Constraint.horisontalInset),
            self.dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.addSubview(self.townLabel)
        self.townLabel.translatesAutoresizingMaskIntoConstraints = false
        self.townLabel.text = "SPb"
        NSLayoutConstraint.activate([
            self.townLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.leadingTrailingInset),
            self.townLabel.trailingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Constraint.horisontalInset),
            self.townLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
}
