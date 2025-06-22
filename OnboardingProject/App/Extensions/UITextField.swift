//
//  UITextField+EyeToggle.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 11/06/2025.
//

import Foundation
import UIKit

extension UITextField {
    
    private var eyeButton: UIButton? {
        return (self.rightView?.subviews.first { $0 is UIButton }) as? UIButton
    }
    
    func configureAsSecureTextField() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: AppAssets.passwordEyeSlash), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        button.center = CGPoint(x: 17.5, y: 15)
        containerView.addSubview(button)
        
        self.rightView = containerView
        self.rightViewMode = .always
        self.isSecureTextEntry = true
    }
    
    @objc private func togglePasswordVisibility() {
        self.isSecureTextEntry.toggle()
        let imageName = self.isSecureTextEntry ? AppAssets.passwordEyeSlash : AppAssets.passwordEye
        self.eyeButton?.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
