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
            .withTintColor(UIColor(named: AppAssets.radioUnSelectedColor)!, renderingMode: .alwaysOriginal)
        radioButton.setImage(unselectedImage, for: .normal)
        
        let selectedImage = AppIcons.radioSelected?
            .withTintColor(UIColor(named: AppAssets.radioSelectedColor)!, renderingMode: .alwaysOriginal)
        
        radioButton.setImage(selectedImage, for: .selected)
        
        radioButton.tintColor = .clear
    }
    
    private func setupButtonActions() {
        radioButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
    }
    
    @objc private func radioButtonTapped() {
        optionSelected?()
    }
    
    func configure(with text: String, isSelected: Bool) {
        label.text = text
        radioButton.isHidden = false
        radioButton.isSelected = isSelected
    }
    
}

