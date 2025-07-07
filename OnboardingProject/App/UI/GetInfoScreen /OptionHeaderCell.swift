//
//  OptionHeaderCell.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 01/07/2025.
//

import UIKit

class OptionHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

