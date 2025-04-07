//
//  CustomButton.swift
//  Kupaline
//
//  Created by Сергей Киселев on 01.03.2025.
//

import UIKit

class CustomButton: UIButton {
    
    private var textColor = UIColor()
    private var title = String()
    private var background = UIColor()
    
    convenience init(textColor: UIColor,
                     background: UIColor,
                     title: String) {
        self.init(type: .custom)
        self.textColor = textColor
        self.title = title
        self.background = background
        setup()
    }
    
    private func setup() {
        self.isEnabled = true
        self.layer.cornerRadius = 16
        self.setTitle(title, for: .normal)
        self.backgroundColor = background
        self.setTitleColor(textColor, for: .normal)
        self.tintColor = textColor
    }
}
