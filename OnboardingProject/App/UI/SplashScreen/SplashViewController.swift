//
//  SplashViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

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
        setupBindings()
    }
    
    
    // MARK: - Actions
    @IBAction
    func signupButtonTapped(_ sender: UIButton) {
        viewModel.handleSignupAction()
    }
    
    @IBAction
    func loginButtonTapped(_ sender: UIButton) {
        viewModel.handleLoginAction()
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
            viewController = SignupViewController()
        case .login:
            viewController = LoginViewController()
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
        let transition = CATransition()
        transition.duration = transitionDuration
        view.window?.layer.add(transition, forKey: kCATransition)
        addFadeTransition(to: view.window?.layer ?? view.layer)
    }
}
