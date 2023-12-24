//
//  SecondScreenViewController.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import UIKit

class SecondScreenViewController: UIViewController, ThirdScreenDelegate {
    
    // MARK: Variables
    private let thirdVC = ThirdScreenViewController(ThirdScreenViewModel())
    
    // MARK: UI Components
    private let separatorView = SeparatorView()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.textColor = .primaryTextColor
        label.font = UIFont.poppinsRegular(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jhon Doe"
        label.textColor = .primaryTextColor
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedUserNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Selected User Name"
        label.textColor = .primaryTextColor
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chooseUserButton: PrimaryButton = {
       let button = PrimaryButton()
        button.setTitle("Choose a User", for: .normal)
        button.addTarget(self, action: #selector(chooseUserButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Life Cycle
    init(name: String) {
        self.nameLabel.text = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
        
        thirdVC.delegate = self
    }
    
    // MARK: UI Setup
    private func setupNavBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .backButtonColor
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Second Screen"
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(separatorView)
        separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(selectedUserNameLabel)
        NSLayoutConstraint.activate([
            selectedUserNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectedUserNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(chooseUserButton)
        NSLayoutConstraint.activate([
            chooseUserButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            chooseUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            chooseUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
    
    // MARK: Actions
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func chooseUserButtonTapped() {
        self.navigationController?.pushViewController(thirdVC, animated: true)
    }
    
    func userSelected(name: String) {
        self.selectedUserNameLabel.text = name
    }
}
