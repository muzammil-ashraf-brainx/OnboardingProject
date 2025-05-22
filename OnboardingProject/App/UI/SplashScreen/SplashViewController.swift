//
//  SplashViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var signupBtn: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - UI Configuration
    
    private func configureUI() {
        signupBtn.addTarget(self, action: #selector(handleSignupBtnTap), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func handleSignupBtnTap() {
        let signupVC = SignupViewController(nibName: "SignupViewController", bundle: nil)
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
}

