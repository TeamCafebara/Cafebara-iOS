//
//  StoreInputView.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/17/24.
//

import UIKit

import SnapKit

final class StoreInputView: UIView {
    
    // MARK: - UI Components
    
    let navigationBar = CustomNavigationView()
    let storeInputTitle = UILabel()
    lazy var storeInputTextField = CustomTextField(placeHolder: I18N.OnboardingRegister.storeInputPlaceholder)
    let nextButton = CustomButton(status: false, 
                                  type: .noBorder,
                                  title: I18N.Common.nextButtonTitle)
    
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

private extension StoreInputView {

    func setUI() {
        backgroundColor = .backgroundBara
    }
    
    func setStyle() {
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        storeInputTitle.do {
            $0.text = I18N.OnboardingRegister.storeInputOwnerTitle
            $0.textColor = .gray7
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .fontBara(.heading)
            $0.asLineHeight(.heading)
        }
    }
    
    func setHierarchy() {
        addSubviews(navigationBar, storeInputTitle, storeInputTextField, nextButton)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        storeInputTitle.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        storeInputTextField.snp.makeConstraints {
            $0.top.equalTo(storeInputTitle.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-14)
            $0.centerX.equalToSuperview()
        }
    }
}
