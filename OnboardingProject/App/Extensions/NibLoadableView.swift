//
//  NibLoadableView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 23/06/2025.
//

import UIKit


protocol NibLoadableView: AnyObject {
    static func instantiate() -> Self
}

extension NibLoadableView where Self: UIView {
    static func instantiate() -> Self {
        let nib = UINib(nibName: Self.identifier ?? "", bundle: nil)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            preconditionFailure("\(AppStrings.AlertTitle.failed) \(String(describing: Self.identifier))")
        }
        return view
    }
    
}
