//
//  InviteCodeView.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/14/24.
//

import UIKit

import SnapKit
import Then

final class InviteCodeView: UIView {
    
    // MARK: - UI Components
    
    let navigationBar = CustomNavigationView()
    private let inviteCodeTitle = UILabel()
    lazy var codeInputTextField = CustomTextField(placeHolder: I18N.OnboardingRegister.codeInputPlaceholder)
    let isCertifyLabel = UILabel()
    lazy var codeCertifyButton = CustomButton(status: false, type: .hasBorder, title: I18N.OnboardingRegister.codeCertifyButtonTitle)
    lazy var nextButton = CustomButton(status: false, type: .noBorder, title: I18N.Common.nextButtonTitle)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setStyle()
        setHierarchy()
        setLayout()
        setDelegate()
        setGesture()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension InviteCodeView {

    func setUI() {
        backgroundColor = .backgroundBara
        isCertifyLabel.isHidden = true
    }
    
    func setStyle() {
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        inviteCodeTitle.do {
            $0.text = I18N.OnboardingRegister.inviteCodeTitle
            $0.textColor = .gray7
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .fontBara(.heading)
            $0.asLineHeight(.heading)
        }
        
        isCertifyLabel.do {
            $0.font = .fontBara(.caption1)
            $0.asLineHeight(.caption1)
        }
    }
    
    func setHierarchy() {
        addSubviews(navigationBar, inviteCodeTitle, codeInputTextField, isCertifyLabel, codeCertifyButton, nextButton)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        inviteCodeTitle.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        codeInputTextField.snp.makeConstraints {
            $0.top.equalTo(inviteCodeTitle.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 33 / 667)
            $0.centerX.equalToSuperview()
        }
        
        isCertifyLabel.snp.makeConstraints {
            $0.top.equalTo(codeInputTextField.snp.bottom).offset(6)
            $0.leading.equalTo(codeInputTextField.snp.leading).offset(12)
        }
        
        codeCertifyButton.snp.makeConstraints {
            $0.top.equalTo(isCertifyLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-14)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setDelegate() {
        codeInputTextField.delegate = self
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
}

extension InviteCodeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if let customTextField = textField as? CustomTextField {
            customTextField.textFieldStatus = .editing
        }
        codeCertifyButton.isEnabled = true
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        print(newText)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let currentText = textField.text ?? ""
        if currentText.isEmpty {
            if let customTextField = textField as? CustomTextField {
                customTextField.textFieldStatus = .normal
            }
            codeCertifyButton.isEnabled = false
        } else {
            codeCertifyButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}
