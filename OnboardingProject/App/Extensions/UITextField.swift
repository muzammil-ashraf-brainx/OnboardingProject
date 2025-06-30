//
//  UITextField+EyeToggle.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 11/06/2025.
//

import UIKit

private var eyeButtonKey: UInt8 = 0

extension UITextField {
    
    private var eyeButton: UIButton? {
        get {
            return objc_getAssociatedObject(self, &eyeButtonKey) as? UIButton
        }
        set {
            objc_setAssociatedObject(self, &eyeButtonKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func configureAsSecureTextField() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: SystemImages.passwordEyeSlash), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        self.eyeButton = button
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        button.center = CGPoint(x: 17.5, y: 15)
        containerView.addSubview(button)
        
        self.rightView = containerView
        self.rightViewMode = .always
        self.isSecureTextEntry = true
    }
    
    @objc private func togglePasswordVisibility() {
        self.isSecureTextEntry.toggle()
        let imageName = self.isSecureTextEntry ? SystemImages.passwordEyeSlash : SystemImages.passwordEye
        eyeButton?.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
