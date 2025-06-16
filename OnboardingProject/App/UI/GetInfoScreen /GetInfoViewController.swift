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
}

// MARK: - GetInfoViewDelegate

extension GetInfoViewController: GetInfoViewDelegate {
    
    func didTapNext() {
        if viewModel.isValid {
        } else {
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

