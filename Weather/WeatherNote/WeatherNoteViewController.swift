//
//  NewWeatherNoteViewController.swift
//  Weather
//
//  Created by Байсангур on 24.03.2023.
//

import Foundation
import UIKit

final class WeatherNoteViewController: UIViewController {
    
    private enum Constraints {
        static let noteTextFieldHorizontalInset: CGFloat = 30
        static let verticalInset: CGFloat = 24
        static let dateLabelLeadingInset: CGFloat = 31
        static let standartHorizontalInset: CGFloat = 30
        static let horizontalBottonInset: CGFloat = 95
        static let verticalSaveInset: CGFloat = 40
    }
    
    private enum Text {
        static let cityHeader = "City"
        static let dateHeader = "Date"
        static let weatherHeader = "Weather"
        static let tempHeader = "Temperature"
        static let infoHeader = "Additional info"
        static let saveButton = "Save"
    }
    
    private let weatherImages = Weather.allCases
    
    private let cityNoteTextField = NoteTextFieldView(settings: .init(header: Text.cityHeader))
    private let tempNoteTextField = NoteTextFieldView(settings: .init(header: Text.tempHeader))
    private let infoNoteTextField = NoteTextFieldView(settings: .init(header: Text.infoHeader))
    
    private lazy var scrollView = UIScrollView()
    private lazy var dateLabel: UILabel = createLabel(text: Text.dateHeader)
    private lazy var weatherLabel: UILabel = createLabel(text: Text.weatherHeader)
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()
    
    private lazy var saveButton = WeatherButton(settings: .init(imageName: nil,
                                                           labelText: Text.saveButton,
                                                           font: .regular16,
                                                           tapHandler: {
        self.onSaveButtonPressed()
    }))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func onSaveButtonPressed() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = AppFonts.bold28.font
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }
    
    func setupLayout() {
        
        let backgroundImageView = UIImageView(image: UIImage(named: "background"))
        self.view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
        
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)])
        
        
        self.scrollView.addSubview(self.cityNoteTextField)
        self.cityNoteTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.cityNoteTextField.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.cityNoteTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: Constraints.noteTextFieldHorizontalInset),
            self.cityNoteTextField.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -Constraints.noteTextFieldHorizontalInset)])
        
        self.scrollView.addSubview(self.dateLabel)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.cityNoteTextField.bottomAnchor, constant: Constraints.verticalInset),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: Constraints.dateLabelLeadingInset)])
        
        self.scrollView.addSubview(self.datePicker)
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.datePicker.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
            self.datePicker.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -Constraints.standartHorizontalInset),
            self.datePicker.leadingAnchor.constraint(equalTo: self.dateLabel.trailingAnchor)])
        
        self.scrollView.addSubview(self.weatherLabel)
        self.weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weatherLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constraints.verticalInset),
            self.weatherLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: Constraints.standartHorizontalInset),
            self.weatherLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -Constraints.standartHorizontalInset)])
        
        self.scrollView.addSubview(self.pickerView)
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pickerView.topAnchor.constraint(equalTo: self.weatherLabel.bottomAnchor, constant: -Constraints.verticalInset),
            self.pickerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: Constraints.standartHorizontalInset),
            self.pickerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -Constraints.standartHorizontalInset)])
        
        self.scrollView.addSubview(self.tempNoteTextField)
        self.tempNoteTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tempNoteTextField.topAnchor.constraint(equalTo: self.pickerView.bottomAnchor, constant: Constraints.verticalInset),
            self.tempNoteTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: Constraints.standartHorizontalInset),
            self.tempNoteTextField.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -Constraints.standartHorizontalInset)])
        
        self.scrollView.addSubview(self.infoNoteTextField)
        self.infoNoteTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.infoNoteTextField.topAnchor.constraint(equalTo: self.tempNoteTextField.bottomAnchor, constant: Constraints.verticalInset),
            self.infoNoteTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: Constraints.standartHorizontalInset),
            self.infoNoteTextField.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -Constraints.standartHorizontalInset)])
        
        self.scrollView.addSubview(self.saveButton)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.saveButton.topAnchor.constraint(equalTo: self.infoNoteTextField.bottomAnchor, constant: Constraints.verticalInset),
            self.saveButton.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -Constraints.verticalSaveInset),
            self.saveButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.saveButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: Constraints.horizontalBottonInset),
            self.saveButton.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -Constraints.horizontalBottonInset)
        ])
    }
    
}

extension WeatherNoteViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weatherImages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weatherImages[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let attributedString = NSAttributedString(string: weatherImages[row].rawValue, attributes: [
            NSAttributedString.Key.font: AppFonts.regular18.font as Any,
            NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return attributedString
    }
    
    
}
