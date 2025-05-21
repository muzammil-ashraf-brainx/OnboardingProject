//
//  SignupView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

class SignupView: UIView {
    
    @IBOutlet weak var googleSignupBtn: UIButton!
    @IBOutlet weak var appleSignupBtn: UIButton!
    @IBOutlet weak var socialContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
            let buttons: [UIButton?] = [googleSignupBtn, appleSignupBtn]
            
            buttons.forEach { button in
                guard let button = button else { return }
                button.layer.cornerRadius = button.frame.height / 2
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.lightGray.cgColor
                button.layer.masksToBounds = true
            }
            
            socialContainerView.layer.cornerRadius = 16
            socialContainerView.layer.masksToBounds = true
        
        }
    
}

