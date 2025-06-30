//
//  SplashView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

class SplashView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblBtnsTitle: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setBtnsTitleText()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        btnSignup.setCornerRadius(18)
        btnSignup.setBorder(width: 0.5, color: .lightGray)
        btnLogin.setCornerRadius(18)
        btnLogin.setBorder(width: 0.5, color: .lightGray)
    }
    
    private func setBtnsTitleText() {
        lblBtnsTitle.text = LocalizationKey.Splash.buttonTitle.localized
    }
    
}
