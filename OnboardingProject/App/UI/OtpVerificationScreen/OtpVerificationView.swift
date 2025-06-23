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
    func resendButtonTapped()
    func verifyButtonTapped()
}

class OtpVerificationView: UIView {

    // MARK: - Outlets
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var codeTextField1: UITextField!
    @IBOutlet weak var codeTextField2: UITextField!
    @IBOutlet weak var codeTextField3: UITextField!
    @IBOutlet weak var codeTextField4: UITextField!
    @IBOutlet weak var resendInfoLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: OtpVerificationViewDelegate?
    
    private var codeTextFields: [UITextField] {
        [codeTextField1, codeTextField2, codeTextField3, codeTextField4]
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIElements()
    }
    
    // MARK: - Setup
    private func setupUIElements() {
        stepLabel.text = LocalizedStrings.otpStepIndicator
        instructionLabel.text = LocalizedStrings.otpInstruction
        resendInfoLabel.text = LocalizedStrings.otpDidNotReceive
        resendButton.setTitle(LocalizedStrings.otpResend, for: .normal)
        verifyButton.setTitle(LocalizedStrings.otpVerify, for: .normal)
        verifyButton.setupFilledButton()

        codeTextFields.forEach {
            $0.keyboardType = .numberPad
            $0.textAlignment = .center
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 5
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    // MARK: - Text Field Logic
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, text.count == 1 else {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            updateVerifyButtonState()
            return
        }

        textField.layer.borderColor = UIColor(named: AppAssets.primaryAppColor)?.cgColor

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
        verifyButton.backgroundColor = isComplete ?
            UIColor(named: AppAssets.primaryAppColor) :
            UIColor.lightGray
    }

    // MARK: - Actions
    @IBAction func resendButtonTapped(_ sender: UIButton) {
        delegate?.resendButtonTapped()
    }
    
    @IBAction func verifyButtonTapped(_ sender: UIButton) {
        delegate?.verifyButtonTapped()
    }
    
}

