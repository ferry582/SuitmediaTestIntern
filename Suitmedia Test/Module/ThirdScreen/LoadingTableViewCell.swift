//
//  LoadingTableViewCell.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 24/12/23.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    // MARK: -Variables
    static let identifier = "LoadingTableViewCell"
    
    // MARK: -UI Components
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    // MARK: -Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -UI Setup
    private func setupView() {
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with data: User) {
    }
}
