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
        btnSignup.setupButton()
        btnLogin.setupButton()
    }
    
    func setBtnsTitleText() {
        lblBtnsTitle.text = "Get instant updates from a fully energetic community"
    }
    
}

