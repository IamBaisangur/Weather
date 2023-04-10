//
//  NoteTextFieldView.swift
//  Weather
//
//  Created by Байсангур on 24.03.2023.
//

import Foundation
import UIKit

class NoteTextFieldView: UIView {
    
    struct Settings {
        let header: String
        let value: String?
        
        init(header: String, value: String? = nil) {
            self.header = header
            self.value = value
        }
    }
    
    private enum Constraints {
        static let textFieldTopInset: CGFloat = 8
        static let textFieldCornerRadius: CGFloat = 16
        static let emptyViewWidth: CGFloat = 16
        static let textFieldHeight: CGFloat = 40
    }

    private enum Texts {
        static let textFiledPlaceholderText = "Start typing here"
    }
    
    private enum Constnts {
        static let textFieldCornerRadius: CGFloat = 16
        static let emptyViewWidth: CGFloat = 16
        static let borderWidth: CGFloat = 1
    }

    private let label: UILabel = {
        let label = UILabel()
        label.font = AppFonts.bold28.font
        label.textColor = .white
        label.text = "City"
        label.textAlignment = .left
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder  = NSAttributedString(string: Texts.textFiledPlaceholderText, attributes: [
                                                                NSAttributedString.Key.font: AppFonts.regular16.font as Any,
                                                                NSAttributedString.Key.foregroundColor: Colors.gray.value])
        textField.backgroundColor = Colors.whiteBackground.value
        textField.layer.cornerRadius = Constraints.textFieldCornerRadius
        
        let emptyView = UIView(frame: .init(x: 0, y: 0, width: Constnts.emptyViewWidth, height: .zero))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.leftView = emptyView
        textField.rightView = emptyView
        textField.layer.borderWidth = Constnts.borderWidth
        textField.layer.borderColor = Colors.white.cgColor
        return textField
    }()
    
    init(settings: Settings) {
        super.init(frame: .zero)
        self.configureView(with: settings)
        self.setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NoteTextFieldView {
    func setupLayout() {
        
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        self.addSubview(self.textField)
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: Constraints.textFieldTopInset),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: Constraints.textFieldHeight)])
    }
    
    func configureView(with settings: Settings) {
        self.label.text = settings.header
        self.textField.text = settings.value
    }
    
}
