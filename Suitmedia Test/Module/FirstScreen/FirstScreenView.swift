//
//  FirstScreenView.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import UIKit

class FirstScreenView: UIView {
    
    // MARK: Variables
    var nextButtonTappedCallback: (() -> Void)?
    var checkButtonTappedCallback: (() -> Void)?
    var name = ""
    var palindromeText = ""
    
    // MARK: UI Components
    private let photoIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_photo")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.placeholder = "Name"
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let palindromeTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.placeholder = "Palindrome"
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let checkButton: PrimaryButton = {
       let button = PrimaryButton()
        button.setTitle("CHECK", for: .normal)
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: PrimaryButton = {
       let button = PrimaryButton()
        button.setTitle("NEXT", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: UI Setup
    private func setupView() {
        addSubview(photoIconImageView)
        NSLayoutConstraint.activate([
            photoIconImageView.topAnchor.constraint(equalTo: topAnchor),
            photoIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photoIconImageView.widthAnchor.constraint(equalToConstant: 116),
            photoIconImageView.heightAnchor.constraint(equalToConstant: 116),
        ])
        
        addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: photoIconImageView.bottomAnchor, constant: 51),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
        
        addSubview(palindromeTextField)
        NSLayoutConstraint.activate([
            palindromeTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            palindromeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            palindromeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
        
       addSubview(checkButton)
        NSLayoutConstraint.activate([
            checkButton.topAnchor.constraint(equalTo: palindromeTextField.bottomAnchor, constant: 45),
            checkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            checkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
        
        addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 15),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: Actions
    @objc private func checkButtonTapped() {
        // send to viewmodel to be checked
        checkButtonTappedCallback?()
    }
    
    @objc private func nextButtonTapped() {
        nextButtonTappedCallback?()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == palindromeTextField {
            palindromeText = palindromeTextField.text ?? ""
        } else if textField == nameTextField {
            name = nameTextField.text ?? ""
        }
    }
}
