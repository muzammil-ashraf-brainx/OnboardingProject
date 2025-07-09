//
//  GetInfoViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/05/2025.
//

import UIKit

// MARK: - GetInfoViewController

class GetInfoViewController: SuperViewController {
    
    @IBOutlet weak var getInfoView: GetInfoView!
    
    private let viewModel = GetInfoViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        getInfoView.delegate = self
        getInfoView.configure(sectionData: viewModel.sections, selectedIndices: viewModel.selectedIndices)
    }
    
    private func showValidationAlert() {
        let alert = UIAlertController(
            title: LocalizationKey.AlertTitle.incompleteForm,
            message: LocalizationKey.AlertMessage.incompleteForm,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: LocalizationKey.AlertButton.ok.localized, style: .default))
        
        present(alert, animated: true)
    }
    
}

// MARK: - GetInfoViewDelegate

extension GetInfoViewController: GetInfoViewDelegate {
    
    func didSelectDateOfBirth(_ date: Date) {
        viewModel.selectedDOB = date
    }
    
    func didTapNext() {
        guard viewModel.isValid else {
            showValidationAlert()
            return
        }
    }
    
    func didUpdateSelection(section: Int, index: Int?) {
        viewModel.selectedIndices[section] = index
        // Convert data section index to collection view section index
        // Data section 0 -> collection view section 1 (options)
        // Data section 1 -> collection view section 3 (options)
        let collectionViewSection = (section * 2) + 1
        getInfoView.updateSelection(section: collectionViewSection, index: index)
    }
}

