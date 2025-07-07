//
//  OtpVerificationView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//

import UIKit

// MARK: - Delegate Protocol
protocol OtpVerificationViewDelegate: AnyObject {
    
    func otpTextDidChange(_ code: String)
}

class OtpVerificationView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet var codeTextFields: [UITextField]!
    @IBOutlet weak var resendInfoLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet private(set) weak var verifyButtonView: UIView!
    
    
    // MARK: - Properties
    weak var delegate: OtpVerificationViewDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIElements()
    }
    
    // MARK: - Setup
    private func setupUIElements() {
        stepLabel.text = LocalizationKey.OTP.stepIndicator.localized
        instructionLabel.text = LocalizationKey.OTP.instruction.localized
        resendInfoLabel.text = LocalizationKey.OTP.didNotReceive.localized
        resendButton.setTitle(LocalizationKey.OTP.resend.localized, for: .normal)
        verifyButton.setTitle(LocalizationKey.OTP.verify.localized, for: .normal)
        verifyButton.setCornerRadius(18)
        verifyButton.setBorder(width: 0.5, color: .lightGray)
        
        
        codeTextFields.forEach {
            $0.keyboardType = .numberPad
            $0.textAlignment = .center
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 5
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    // MARK: - Text Field Logic
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, text.count == 1 else {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            updateVerifyButtonState()
            return
        }
        
        textField.layer.borderColor = UIColor(resource: .primary).cgColor
        
        if let index = codeTextFields.firstIndex(of: textField), index < codeTextFields.count - 1 {
            codeTextFields[index + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        let otpCode = codeTextFields.compactMap { $0.text }.joined()
        delegate?.otpTextDidChange(otpCode)
        updateVerifyButtonState()
    }
    
    private func updateVerifyButtonState() {
        let isComplete = codeTextFields.allSatisfy { ($0.text?.count ?? 0) == 1 }
        verifyButton.isEnabled = isComplete
        verifyButton.backgroundColor = isComplete
        ? UIColor(resource: .primary)
        : UIColor.lightGray
    }
}

