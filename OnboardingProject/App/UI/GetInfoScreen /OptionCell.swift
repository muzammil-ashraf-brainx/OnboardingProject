//
//  OptionCell.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/05/2025.
//

import UIKit

// MARK: - OptionCell
class OptionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var radioButton: UIButton!
    
    // MARK: - Properties
    var optionSelected: (() -> Void)?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
        setupButtonActions()
    }
    
    // MARK: - Configuration
    private func configureAppearance() {
        let unselectedImage = AppIcons.radioUnselected?
            .withTintColor(AppColors.radioUnselected, renderingMode: .alwaysOriginal)
        radioButton.setImage(unselectedImage, for: .normal)
        
        let selectedImage = AppIcons.radioSelected?
            .withTintColor(AppColors.radioSelected, renderingMode: .alwaysOriginal)
        radioButton.setImage(selectedImage, for: .selected)
        
        radioButton.tintColor = .clear
    }
    
    private func setupButtonActions() {
        radioButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func radioButtonTapped() {
        optionSelected?()
    }
    
    // MARK: - Public Methods
    func configure(with text: String, isSelected: Bool) {
        label.text = text
        radioButton.isHidden = false
        radioButton.isSelected = isSelected
    }
    
}

