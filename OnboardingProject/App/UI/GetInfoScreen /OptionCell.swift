//
//  OptionCell.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/05/2025.
//

import UIKit

class OptionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var radioLabel: UILabel!
    @IBOutlet private weak var radioButton: UIButton!
    
    var optionSelected: (() -> Void)?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
        setupButtonActions()
    }
    
    // MARK: - Appearance Configuration
    private func configureAppearance() {
        let unselectedColor = UIColor(resource: .lightGray)
        let selectedColor = UIColor(resource: .primary)
        
        let unselectedImage = UIImage(systemName: SystemImages.radioUnselected)?
            .withTintColor(unselectedColor, renderingMode: .alwaysOriginal)
        
        let selectedImage = UIImage(systemName: SystemImages.radioSelected)?
            .withTintColor(selectedColor, renderingMode: .alwaysOriginal)
        
        radioButton.setImage(unselectedImage, for: .normal)
        radioButton.setImage(selectedImage, for: .selected)
        
        radioButton.tintColor = .clear
        radioButton.isUserInteractionEnabled = true
    }
    
    // MARK: - Setup
    private func setupButtonActions() {
        radioButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func radioButtonTapped() {
        optionSelected?()
    }
    
    // MARK: - Public Configuration
    func configure(with text: String, isSelected: Bool) {
        radioLabel.text = text
        radioButton.isSelected = isSelected
    }
    
}

