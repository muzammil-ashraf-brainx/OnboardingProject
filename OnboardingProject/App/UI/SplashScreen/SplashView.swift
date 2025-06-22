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
    func setupView() {
        btnSignup?.setupFilledButton()
        btnLogin?.setupFilledButton()
    }
    
    func setBtnsTitleText() {
        lblBtnsTitle.text = LocalizedStrings.splashButtonTitle
    }
    
    // MARK: - Configuration
    func configureButtonActions(signupAction: Selector, loginAction: Selector, target: Any) {
        btnSignup.addTarget(target, action: signupAction, for: .touchUpInside)
        btnLogin.addTarget(target, action: loginAction, for: .touchUpInside)
    }
    
}
