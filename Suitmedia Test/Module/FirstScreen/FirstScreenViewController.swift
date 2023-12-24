//
//  ViewController.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    // MARK: Variables
    private let viewModel: FirstScreenViewModel
    private var alertMessage = ""
    
    // MARK: UI Components
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let firstScreenView: FirstScreenView = {
        let view = FirstScreenView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: Life Cycle
    init(_ viewModel: FirstScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        firstScreenView.nextButtonTappedCallback = {
            guard !self.firstScreenView.name.isEmpty else {
                self.alertMessage = "Name Can't be empty!"
                self.showAlert()
                return
            }
            self.navigationController?.pushViewController(SecondScreenViewController(name: self.firstScreenView.name), animated: true)
        }
        
        firstScreenView.checkButtonTappedCallback = {
            self.viewModel.isPalindrome(text: self.firstScreenView.palindromeText)
            self.showAlert()
        }
        
        viewModel.palindromeMessage.bind { [weak self] message in
            self?.alertMessage = message ?? ""
        }
    }
    
    // MARK: UI Setup
    private func setupView() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(firstScreenView)
        NSLayoutConstraint.activate([
            firstScreenView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

