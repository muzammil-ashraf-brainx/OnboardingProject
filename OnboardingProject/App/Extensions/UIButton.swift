//
//  UIButton.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 20/05/2025.
//


import UIKit

extension UIButton {
    func setupFilledButton() {
        self.layer.cornerRadius = 18
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
    func setupBorderdButton() {
        self.layer.cornerRadius = 18
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
}
