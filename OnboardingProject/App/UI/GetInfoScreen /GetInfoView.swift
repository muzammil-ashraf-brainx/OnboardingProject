//
//  GetInfoView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/05/2025.
//

import UIKit

// MARK: - GetInfoViewDelegate
protocol GetInfoViewDelegate: AnyObject {
    
    func didSelectDateOfBirth(_ date: Date)
    func didUpdateSelection(section: Int, index: Int?)
}

class GetInfoView: UIView {
    
    // MARK: - Types
    enum Section {
        case header(title: String)
        case options(items: [String], selectedIndex: Int?)
        
        var itemCount: Int {
            switch self {
            case .header:
                return 1
            case .options(let items, _):
                return items.count
            }
        }
    }
    
    // MARK: - Properties
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    weak var delegate: GetInfoViewDelegate?
    
    private let dateOfBirthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: SystemImages.calendar), for: .normal)
        button.setTitle(LocalizationKey.GetInfo.dob.localized, for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizationKey.GetInfo.next.localized, for: .normal)
        button.backgroundColor = UIColor(resource: .primary)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private var overlayView: UIView!
    private var datePicker: UIDatePicker!
    
    private var sections: [Section] = []
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupCollectionView()
        setupDatePickerOverlay()
    }
    
    // MARK: - Public Methods
    func configure(sectionData: [[String]], selectedIndices: [Int?]) {
        var newSections: [Section] = []
        for (index, items) in sectionData.enumerated() {
            let headerTitle = index == 0 || index == 1 ? LocalizationKey.GetInfo.header.localized : ""
            newSections.append(.header(title: headerTitle))
            newSections.append(.options(items: items, selectedIndex: selectedIndices[index]))
        }
        self.sections = newSections
        collectionView.reloadData()
    }
    
    func updateSelection(section: Int, index: Int?) {
        guard case .options(var items, _) = sections[section] else { return }
        sections[section] = .options(items: items, selectedIndex: index)
        collectionView.reloadSections(IndexSet(integer: section))
        delegate?.didUpdateSelection(section: section / 2, index: index)
    }
    
    func updateDateOfBirthButton(title: String) {
        dateOfBirthButton.setTitle("  \(title)", for: .normal)
        dateOfBirthButton.setImage(UIImage(systemName: SystemImages.calendar), for: .normal)
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .white
        addSubview(dateOfBirthButton)
        addSubview(nextButton)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        dateOfBirthButton.addTarget(self, action: #selector(dateOfBirthTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dateOfBirthButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            dateOfBirthButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateOfBirthButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dateOfBirthButton.heightAnchor.constraint(equalToConstant: 44),
            
            nextButton.topAnchor.constraint(equalTo: dateOfBirthButton.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(for: OptionCell.self)
        collectionView.registerNib(for: OptionHeaderCell.self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
    private func setupDatePickerOverlay() {
        overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.isHidden = true
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .white
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        overlayView.addSubview(datePicker)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideDatePicker))
        overlayView.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            datePicker.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            datePicker.widthAnchor.constraint(equalTo: overlayView.widthAnchor, multiplier: 0.85),
            datePicker.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    // MARK: - Actions
    @objc private func dateOfBirthTapped() {
        overlayView.isHidden = false
    }
    
    @objc private func hideDatePicker() {
        overlayView.isHidden = true
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: sender.date)
        updateDateOfBirthButton(title: dateString)
        delegate?.didSelectDateOfBirth(sender.date)
        hideDatePicker()
    }
}

// MARK: - UICollectionViewDataSource
extension GetInfoView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .header(let title):
            let cell: OptionHeaderCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(title: title)
            return cell
            
        case .options(let items, let selectedIndex):
            let cell: OptionCell = collectionView.dequeueCell(for: indexPath)
            let option = items[indexPath.item]
            let isSelected = selectedIndex == indexPath.item
            
            cell.configure(with: option, isSelected: isSelected)
            cell.optionSelected = { [weak self] in
                self?.updateSelection(for: indexPath.section, index: indexPath.item)
            }
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension GetInfoView: UICollectionViewDelegate {
    private func updateSelection(for section: Int, index: Int) {
        guard case .options(_, let currentIndex) = sections[section] else { return }
        let newIndex = currentIndex == index ? nil : index
        updateSelection(section: section, index: newIndex)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GetInfoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch sections[indexPath.section] {
        case .header:
            return CGSize(width: collectionView.bounds.width, height: 40)
        case .options:
            let totalWidth = collectionView.bounds.width
            let minItemWidth: CGFloat = 160
            let spacing: CGFloat = 10
            let columns = max(Int(totalWidth / minItemWidth), 1)
            let totalSpacing = CGFloat(columns - 1) * spacing
            let availableWidth = totalWidth - totalSpacing
            let itemWidth = floor(availableWidth / CGFloat(columns))
            return CGSize(width: itemWidth, height: 48)
        }
        
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
        10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
}

