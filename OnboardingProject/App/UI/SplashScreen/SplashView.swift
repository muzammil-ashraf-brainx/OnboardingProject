//
//  SplashView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

class SplashView: UIView {
    
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblBtnsTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setBtnsTitleText()
    }
    
    func setupView() {
        
        btnSignup.setupButton()
        btnLogin.setupButton()
    }
    
    func setBtnsTitleText(){
        lblBtnsTitle.text =  "Get instant updates from a fully energetic community"
    }
    

}

