//
//  SplashViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var signupBtn: UIButton!
    @IBOutlet private weak var loginBtn: UIButton!
    
    // MARK: - Transition Constants
    private let transitionDuration: TimeInterval = 0.5
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        setupButtons()
    }
    
    private func setupButtons() {
        [signupBtn, loginBtn].forEach {
            $0?.layer.cornerRadius = 15
            $0?.layer.masksToBounds = true
        }
        
        signupBtn.addTarget(self, action: #selector(handleSignupBtnTap), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(handleLoginBtnTap), for: .touchUpInside)
    }
    
    // MARK: - Navigation
    private func navigateTo(_ viewController: UIViewController) {
        if let navController = navigationController {
            addFadeTransition(to: navController.view.layer)
            navController.pushViewController(viewController, animated: false)
        } else {
            viewController.modalPresentationStyle = .fullScreen
            addFlipTransition()
            present(viewController, animated: false)
        }
    }
    
    private func addFadeTransition(to layer: CALayer) {
        let transition = CATransition()
        transition.duration = transitionDuration
        transition.type = .fade
        layer.add(transition, forKey: nil)
    }
    
    private func addFlipTransition() {
        if #available(iOS 13.0, *) {
            let transition = CATransition()
            transition.duration = transitionDuration
            view.window?.layer.add(transition, forKey: kCATransition)
        } else {
            // Fallback for earlier iOS versions
            addFadeTransition(to: view.window?.layer ?? view.layer)
        }
    }
    
    // MARK: - Button Actions
    @objc private func handleSignupBtnTap() {
        let signupVC = SignupViewController(nibName: "SignupViewController", bundle: nil)
        navigateTo(signupVC)
    }
    
    @objc private func handleLoginBtnTap() {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigateTo(loginVC)
    }
}
