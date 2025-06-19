//
//  GetInfoViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/05/2025.
//

import UIKit

// MARK: - GetInfoViewController

class GetInfoViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var getInfoView: GetInfoView!
    
    // MARK: - Properties
    
    private let viewModel = GetInfoViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        getInfoView.delegate = self
        getInfoView.configure(sections: viewModel.sections, selectedIndices: viewModel.selectedIndices)
    }
    
    private func showValidationAlert() {
        let alert = UIAlertController(
            title: "Incomplete Form",
            message: "Please complete all required fields before proceeding.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - GetInfoViewDelegate

extension GetInfoViewController: GetInfoViewDelegate {
    func didTapNext() {
        guard viewModel.isValid else {
            showValidationAlert()
            return
        }
    }
    
    func didSelectDOB(_ date: Date) {
        viewModel.selectedDOB = date
    }
    
    func didUpdateSelection(section: Int, index: Int?) {
        viewModel.selectedIndices[section] = index
        getInfoView.updateSelection(section: section, index: index)
    }
    
}

// MARK: - NibLoadableViewController

extension GetInfoViewController: NibLoadableViewController {}
