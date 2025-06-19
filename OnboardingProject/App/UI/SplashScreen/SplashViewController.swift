//
//  SplashViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

// MARK: - SplashViewController
class SplashViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private var splashView: SplashView!
    
    // MARK: - Properties
    private let viewModel: SplashViewModel
    private let transitionDuration: TimeInterval = 0.5
    
    // MARK: - Initialization
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: SplashViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = SplashViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        splashView.configureButtonActions(
            signupAction: #selector(handleSignupBtnTap),
            loginAction: #selector(handleLoginBtnTap),
            target: self
        )
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        viewModel.onNavigate = { [weak self] destination in
            self?.navigateTo(destination)
        }
    }
    
    // MARK: - Navigation
    private func navigateTo(_ destination: SplashViewModel.NavigationDestination) {
        let viewController: UIViewController
        
        switch destination {
        case .signup:
            viewController = SignupViewController.instantiate()
        case .login:
            viewController = LoginViewController.instantiate()
        }
        
        guard let window = view.window else {
            presentModally(viewController)
            return
        }
        
        if let navController = navigationController {
            addFadeTransition(to: navController.view.layer)
            navController.pushViewController(viewController, animated: false)
        } else {
            presentModally(viewController)
        }
    }
    
    private func presentModally(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        addFlipTransition()
        present(viewController, animated: false)
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
            addFadeTransition(to: view.window?.layer ?? view.layer)
        }
    }
    
    // MARK: - Button Actions
    @objc private func handleSignupBtnTap() {
        viewModel.handleSignupAction()
    }
    
    @objc private func handleLoginBtnTap() {
        viewModel.handleLoginAction()
    }
    
}

