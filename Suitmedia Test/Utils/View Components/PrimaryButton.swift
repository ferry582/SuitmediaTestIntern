//
//  PrimaryButton.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import UIKit

class PrimaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        clipsToBounds = true
        layer.cornerRadius = 12
        
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        
        tintColor = .white
        backgroundColor = UIColor.bgButtonColor
        titleLabel?.font = UIFont.poppinsSemiBold(size: 14)
    }
}
