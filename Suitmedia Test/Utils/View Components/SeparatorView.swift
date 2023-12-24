//
//  SeparatorView.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import UIKit

class SeparatorView: UIView {
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
        heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        backgroundColor = .greyBorderColor
    }
}
