//
//  RegisterCompleteView.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/18/24.
//

import UIKit

import SnapKit

final class RegisterCompleteView: UIView {

    // MARK: - UI Components
    
    let navigationBar = CustomNavigationView()
    let registerCompleteTitle = UILabel()
    lazy var completeImage = UIImageView(image: .profile)
    let startButton = CustomButton(status: true, 
                                   type: .noBorder,
                                   title: I18N.OnboardingRegister.startButtonTitle)
    
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

private extension RegisterCompleteView {

    func setUI() {
        backgroundColor = .backgroundBara
    }
    
    func setStyle() {
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        registerCompleteTitle.do {
            $0.text = I18N.OnboardingRegister.registerCompleteTitle
            $0.textColor = .gray7
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .fontBara(.heading)
            $0.asLineHeight(.heading)
        }
    }
    
    func setHierarchy() {
        addSubviews(navigationBar, registerCompleteTitle, completeImage, startButton)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        registerCompleteTitle.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        completeImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(155)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-14)
            $0.centerX.equalToSuperview()
        }
    }
}
