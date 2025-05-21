//
//  SplashViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        signupBtn.addTarget(self, action: #selector(handleSignupBtnTap), for: .touchUpInside)
    }
    
    @objc private func handleSignupBtnTap() {
        let signupVC = SignupViewController(nibName: "SignupViewController", bundle: nil)
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    
}

