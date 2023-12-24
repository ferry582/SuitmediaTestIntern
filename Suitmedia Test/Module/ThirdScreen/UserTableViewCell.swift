//
//  UserTableViewCell.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    // MARK: -Variables
    static let identifier = "UserTableViewCell"
    
    // MARK: -UI Components
    private let avatarImage: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 49, height: 49))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = iv.frame.height/2
        iv.clipsToBounds = true
        iv.sd_imageIndicator = SDWebImageActivityIndicator.gray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryTextColor
        label.font = .poppinsMedium(size: 16)
        label.text = "Firstname"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryTextColor
        label.font = .poppinsMedium(size: 16)
        label.text = "Lastname"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryTextColor
        label.font = .poppinsMedium(size: 10)
        label.text = "email@email.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separator: UIView = SeparatorView()

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
        contentView.addSubview(avatarImage)
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            avatarImage.heightAnchor.constraint(equalToConstant: 49),
            avatarImage.widthAnchor.constraint(equalToConstant: 49)
        ])
        
        contentView.addSubview(firstNameLabel)
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 4),
            firstNameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 20)
        ])
        
        contentView.addSubview(lastNameLabel)
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.topAnchor),
            lastNameLabel.leadingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor, constant: 4)
        ])
        
        contentView.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: -4),
            emailLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 20)
        ])
        
        contentView.addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    func configure(with data: User) {
        firstNameLabel.text = data.firstName
        lastNameLabel.text = data.lastName
        emailLabel.text = data.email
        avatarImage.sd_setImage(with: data.avatar)
    }
}
