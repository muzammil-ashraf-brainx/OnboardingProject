//
//  UICollectionView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/06/2025.
//
import UIKit

extension UICollectionView {
    
    func registerNib<T: UICollectionViewCell>(for cellType: T.Type) {
        let nib = UINib(nibName: cellType.reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath)
        return cell as! T
    }
    
}
