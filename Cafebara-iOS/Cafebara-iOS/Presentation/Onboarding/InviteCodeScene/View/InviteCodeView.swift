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
    let inviteCodeTitle = UILabel()
    lazy var codeInputTextField = CustomTextField(placeHolder: I18N.OnboardingRegister.codeInputPlaceholder)
    let isCertifyLabel = UILabel()
    lazy var codeCertifyButton = CustomButton(status: false, 
                                              type: .hasBorder,
                                              title: I18N.OnboardingRegister.codeCertifyButtonTitle)
    lazy var nextButton = CustomButton(status: false, 
                                       type: .noBorder,
                                       title: I18N.Common.nextButtonTitle)
    
    private let ownerInviteCodeView = UIView()
    let ownerInviteCodeLabel = UILabel()
    let codePasteView = UIView()
    private let codePasteStackView = UIStackView()
    private let codePasteImage = UIImageView(image: .icCpoy)
    private let codePasteTitle = UILabel()
    let codeShareView = UIView()
    private let codeShareStackView = UIStackView()
    private let codeShareImage = UIImageView(image: .icShare)
    private let codeShareTitle = UILabel()
    let codePasteToast = CustomToastMessage(title: I18N.OnboardingRegister.codePastToastTitle)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setStyle()
        setHierarchy()
        setLayout()
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
        codePasteToast.isHidden = true
    }
    
    func setStyle() {
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        inviteCodeTitle.do {
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
        
        ownerInviteCodeView.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .blue10
        }
        
        /// TODO: 서버통신 이후 bind
        ownerInviteCodeLabel.do {
            $0.text = "CAFEBARA-240119"
            $0.textColor = .gray8
            $0.textAlignment = .center
            $0.font = .fontBara(.title3)
            $0.asLineHeight(.title3)
        }
        
        [codePasteView, codeShareView].forEach({
            $0.backgroundColor = .whiteBara
            $0.setRoundBorder(borderColor: .gray5, borderWidth: 1, cornerRadius: 8)
        })
        
        [codePasteStackView, codeShareStackView].forEach({
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
        })
        
        codePasteTitle.do {
            $0.text = I18N.OnboardingRegister.codePasteTitle
        }
        
        codeShareTitle.do {
            $0.text = I18N.OnboardingRegister.codeShareTitle
        }
        
        [codePasteTitle, codeShareTitle].forEach({
            $0.textColor = .gray5
            $0.font = .fontBara(.body2)
            $0.asLineHeight(.body2)
        })
    }
    
    func setHierarchy() {
        ownerInviteCodeView.addSubviews(ownerInviteCodeLabel)
        codePasteStackView.addArrangedSubviews(codePasteImage, codePasteTitle)
        codeShareStackView.addArrangedSubviews(codeShareImage, codeShareTitle)
        codePasteView.addSubview(codePasteStackView)
        codeShareView.addSubview(codeShareStackView)
        addSubviews(navigationBar, inviteCodeTitle, codeInputTextField, isCertifyLabel, codeCertifyButton, ownerInviteCodeView, codePasteView, codeShareView, nextButton, codePasteToast)
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
            $0.top.equalTo(inviteCodeTitle.snp.bottom).offset(40)
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
        
        ownerInviteCodeView.snp.makeConstraints {
            $0.top.equalTo(inviteCodeTitle.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 95 / 667)
        }
        
        ownerInviteCodeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        [codePasteView, codeShareView].forEach({
            $0.snp.makeConstraints {
                $0.top.equalTo(ownerInviteCodeView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 18 / 667)
                $0.width.equalTo((SizeLiterals.Screen.screenWidth - 55) / 2)
                $0.height.equalTo(SizeLiterals.Screen.screenHeight * 52 / 667)
            }
        })
        
        codePasteView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
        }
        
        codeShareView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
        }
        
        [codePasteStackView, codeShareStackView].forEach({
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        })
        
        [codePasteImage, codeShareImage].forEach({
            $0.snp.makeConstraints {
                $0.size.equalTo(24)
            }
        })
        
        codePasteToast.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 52 / 667)
        }
    }
}

extension InviteCodeView {
    
    func setComponent(isOwner: Bool) {
        if isOwner {
            codeInputTextField.isHidden = true
            codeCertifyButton.isHidden = true
            ownerInviteCodeView.isHidden = false
            codePasteView.isHidden = false
            codeShareView.isHidden = false
            nextButton.isEnabled = true
        } else {
            codeInputTextField.isHidden = false
            codeCertifyButton.isHidden = false
            ownerInviteCodeView.isHidden = true
            codePasteView.isHidden = true
            codeShareView.isHidden = true
            nextButton.isEnabled = false
        }
    }
    
    func configureOwnerInviteCode(code: String) {
        ownerInviteCodeLabel.text = code
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
