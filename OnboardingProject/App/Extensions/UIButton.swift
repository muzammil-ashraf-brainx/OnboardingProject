//
//  UIButton.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 20/05/2025.
//


import UIKit

extension UIButton {
    
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
}
