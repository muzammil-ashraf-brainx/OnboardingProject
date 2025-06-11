//
//  UITextField+EyeToggle.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 11/06/2025.
//

import Foundation
import UIKit

extension UITextField {
    
    func addPasswordToggle(isVisible: Bool, target: Any?, action: Selector) {
        let eyeButton = UIButton(type: .custom)
        let imageName = isVisible ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        eyeButton.contentMode = .scaleAspectFit
        eyeButton.addTarget(target, action: action, for: .touchUpInside)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        eyeButton.center = CGPoint(x: 17.5, y: 15)
        containerView.addSubview(eyeButton)
        
        self.rightView = containerView
        self.rightViewMode = .always
        self.isSecureTextEntry = true
    }
    
    func updateEyeIcon(isVisible: Bool) {
        guard let container = self.rightView,
              let button = container.subviews.first as? UIButton else { return }
        let imageName = isVisible ? "eye" : "eye.slash"
        button.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
