//
//  GetInfoView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/05/2025.
//

import UIKit

// MARK: - GetInfoViewDelegate
protocol GetInfoViewDelegate: AnyObject {
    func didTapNext()
    func didSelectDOB(_ date: Date)
    func didUpdateSelection(section: Int, index: Int?)
}

// MARK: - GetInfoView
class GetInfoView: UIView {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: GetInfoViewDelegate?
    
    private let dobButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: AppIcons.calendar), for: .normal)
        button.setTitle(LocalizedStrings.getInfoDOB, for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.getInfoNext, for: .normal)
        button.backgroundColor = AppColors.primary
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.setupButton()
        return button
    }()
    
    private var overlayView: UIView!
    private var popupDatePicker: UIDatePicker!
    
    private var sections: [[String]] = []
    private var selectedIndices: [Int?] = []
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupCollectionView()
        setupOverlayDatePicker()
    }
    
    // MARK: - Configuration
    func configure(sections: [[String]], selectedIndices: [Int?]) {
        self.sections = sections
        self.selectedIndices = selectedIndices
        collectionView.reloadData()
    }
    
    func updateSelection(section: Int, index: Int?) {
        selectedIndices[section] = index
        collectionView.reloadSections(IndexSet(integer: section))
    }
    
    func updateDOBButton(title: String) {
        dobButton.setTitle("  \(title)", for: .normal)
        dobButton.setImage(UIImage(systemName: AppIcons.calendar), for: .normal)
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .white
        addSubview(dobButton)
        addSubview(nextButton)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        dobButton.addTarget(self, action: #selector(dobTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dobButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            dobButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dobButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dobButton.heightAnchor.constraint(equalToConstant: 44),
            
            nextButton.topAnchor.constraint(equalTo: dobButton.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "OptionCell", bundle: nil), forCellWithReuseIdentifier: "OptionCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
    private func setupOverlayDatePicker() {
        overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.isHidden = true
        
        popupDatePicker = UIDatePicker()
        popupDatePicker.datePickerMode = .date
        popupDatePicker.preferredDatePickerStyle = .wheels
        popupDatePicker.backgroundColor = .white
        popupDatePicker.translatesAutoresizingMaskIntoConstraints = false
        popupDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        overlayView.addSubview(popupDatePicker)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideDatePicker))
        overlayView.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.addSubview(overlayView)
            
            NSLayoutConstraint.activate([
                overlayView.topAnchor.constraint(equalTo: window.topAnchor),
                overlayView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                overlayView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                overlayView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                
                popupDatePicker.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
                popupDatePicker.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
                popupDatePicker.widthAnchor.constraint(equalTo: overlayView.widthAnchor, multiplier: 0.85),
                popupDatePicker.heightAnchor.constraint(equalToConstant: 250)
            ])
        }
    }
    
    // MARK: - Actions
    
    @objc private func dobTapped() {
        overlayView.isHidden = false
    }
    
    @objc private func hideDatePicker() {
        overlayView.isHidden = true
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: sender.date)
        updateDOBButton(title: dateString)
        delegate?.didSelectDOB(sender.date)
        hideDatePicker()
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapNext()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension GetInfoView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCell", for: indexPath) as? OptionCell else {
            fatalError("Failed to dequeue OptionCell")
        }
        
        let text = sections[indexPath.section][indexPath.item]
        let isSelected = selectedIndices[indexPath.section] == indexPath.item
        cell.configure(with: text, isSelected: isSelected)
        cell.optionSelected = { [weak self] in
            self?.updateSelection(for: indexPath.section, index: indexPath.item)
        }
        
        return cell
    }
    
    private func updateSelection(for section: Int, index: Int) {
        selectedIndices[section] = (selectedIndices[section] == index) ? nil : index
        collectionView.reloadSections(IndexSet(integer: section))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
        header.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel()
        label.text = LocalizedStrings.getInfoHeader
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: header.topAnchor),
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: header.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: header.bottomAnchor)
        ])
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width
        let minItemWidth: CGFloat = 160
        let spacing: CGFloat = 10
        let columns = max(Int(totalWidth / minItemWidth), 1)
        let totalSpacing = CGFloat(columns - 1) * spacing
        let availableWidth = totalWidth - totalSpacing
        let itemWidth = floor(availableWidth / CGFloat(columns))
        
        return CGSize(width: itemWidth, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
}

