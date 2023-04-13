//
//  CustomWeatherView.swift
//  Weather
//
//  Created by Байсангур on 05.04.2023.
//

import UIKit

protocol ICustomWeatherView: AnyObject {
    var tapButtonHandler: (() -> ())? { get set }
    func setupWeatherData(_ modelData: CurrentWeatherModel)
}

final class CustomWeatherView: UIView, ICustomWeatherView {
    
    private enum Constants {
        static let horisontalSearch = CGFloat(30)
        static let cornerRadius = CGFloat(16)
        static let searchHeight = CGFloat(58)
        
        static let topImageViewInset = CGFloat(16)
        static let imageViewSize = CGFloat(100)
        
        static let emptyViewWidth = CGFloat(16)
        
        static let widgetViewTopInset = CGFloat(16)
        static let widgetViewHorizontalInset = CGFloat(30)
        
        static let buttonHorisontalInset = CGFloat(92)
        static let buttonTopInset = CGFloat(35)
        static let weatherButtonImage = "edit"
    }
    
    private enum Texts {
        static let searchTFPlaceholder = "Search here"
        static let weatherButtonText = "New weather note"
    }
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.masksToBounds = true
        textField.attributedPlaceholder  = NSAttributedString(string: Texts.searchTFPlaceholder, attributes: [
                                                                NSAttributedString.Key.font: AppFonts.regular18.font as Any,
                                                                NSAttributedString.Key.foregroundColor: Colors.lightBlue.value])
        textField.backgroundColor = .white
        
        let emptyView = UIView(frame: .init(x: 0, y: 0, width: Constants.emptyViewWidth, height: .zero))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.leftView = emptyView
        textField.rightView = emptyView
        return textField
    }()
    
    private let weatherIconImageView = UIImageView()
    private let widgetView = WeatherWidgetView()
    
    private lazy var newNoteButton = WeatherButton(settings: .init(imageName: Constants.weatherButtonImage,
                                                              labelText: Texts.weatherButtonText,
                                                              font: .regular16,
                                                              tapHandler: {
        self.tapButtonHandler?()
    }))
    
    var tapButtonHandler: (() -> ())?
    
    func setupWeatherData(_ modelData: CurrentWeatherModel) {
        self.weatherIconImageView.image = modelData.weatherType.image
        self.widgetView.setupWeatherData(modelData)
    }
    
    init() {
        super.init(frame: .zero)
        self.setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomWeatherView {
    
    func setupLayout() {
        
        let backgroundImageView = UIImageView(image: UIImage(named: "background"))
        self.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        self.addSubview(self.searchTextField)
        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.searchTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.horisontalSearch),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.horisontalSearch),
            self.searchTextField.heightAnchor.constraint(equalToConstant: Constants.searchHeight)])
        
        self.addSubview(self.weatherIconImageView)
        self.weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weatherIconImageView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: Constants.topImageViewInset),
            self.weatherIconImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.weatherIconImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize),
            self.weatherIconImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize)])
        
        self.addSubview(self.widgetView)
        self.widgetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widgetView.topAnchor.constraint(equalTo: self.weatherIconImageView.bottomAnchor, constant: Constants.widgetViewTopInset),
            self.widgetView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.widgetViewHorizontalInset),
            self.widgetView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.widgetViewHorizontalInset)
        ])
        
        self.addSubview(self.newNoteButton)
        self.newNoteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.newNoteButton.topAnchor.constraint(equalTo: self.widgetView.bottomAnchor, constant: Constants.buttonTopInset),
            self.newNoteButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.buttonHorisontalInset),
            self.newNoteButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.buttonHorisontalInset)
        ])
    }

}
