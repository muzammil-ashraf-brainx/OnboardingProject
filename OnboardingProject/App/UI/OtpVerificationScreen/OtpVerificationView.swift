//
//  OtpVerificationView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//

// MARK: - Delegate Protocol
protocol OtpVerificationViewDelegate: AnyObject {
    func otpTextDidChange(_ code: String)
    func resendButtonTapped()
    func verifyButtonTapped()
    
}

import UIKit

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
    
    weak var delegate: OtpVerificationViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIElements()
    }
    
    private func setupUIElements() {
        stepLabel.text = LocalizedStrings.otpStepIndicator
        instructionLabel.text = LocalizedStrings.otpInstruction
        resendInfoLabel.text = LocalizedStrings.otpDidNotReceive

        verifyButton.setTitle(LocalizedStrings.otpVerify, for: .normal)
        resendButton.setTitle(LocalizedStrings.otpResend, for: .normal)
        
        let textFields = [codeTextField1, codeTextField2, codeTextField3, codeTextField4]
        for textField in textFields {
            textField?.keyboardType = .numberPad
            textField?.textAlignment = .center
            textField?.layer.borderWidth = 1.0
            textField?.layer.cornerRadius = 5
            textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        verifyButton?.setupButton()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, text.count == 1 else {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            updateVerifyButtonState()
            return
        }

        textField.layer.borderColor = UIColor(hex: "#745E27")?.cgColor

        let textFields = [codeTextField1, codeTextField2, codeTextField3, codeTextField4]
        if let index = textFields.firstIndex(of: textField), index < textFields.count - 1 {
            textFields[index + 1]?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        let otpCode = textFields.compactMap { $0?.text }.joined()
        delegate?.otpTextDidChange(otpCode)

        updateVerifyButtonState()
    }

    
    private func updateVerifyButtonState() {
        let codeFields = [codeTextField1, codeTextField2, codeTextField3, codeTextField4]
        let isComplete = codeFields.allSatisfy { ($0?.text?.count ?? 0) == 1 }

        if isComplete {
            verifyButton.backgroundColor = UIColor(hex: "#745E27")
            verifyButton.isEnabled = true
        }
        else {
                verifyButton.backgroundColor = UIColor.lightGray 
                verifyButton.isEnabled = false
            }
    }

    
    @IBAction func resendButtonTapped(_ sender: UIButton) {
        delegate?.resendButtonTapped()
    }
    
    @IBAction func verifyButtonTapped(_ sender: UIButton) {
        print("Pressed with")
        delegate?.verifyButtonTapped()
    }
}


