//
//  UIViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/06/2025.
//

import UIKit

protocol NibLoadableViewController {
    static func instantiate() -> Self
}

extension NibLoadableViewController where Self: UIViewController {
    static func instantiate() -> Self {
        return Self(nibName: String(describing: Self.self), bundle: nil)
    }
    
}
