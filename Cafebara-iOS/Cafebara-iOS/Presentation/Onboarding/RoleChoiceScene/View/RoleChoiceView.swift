//
//  RoleChoiceView.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/12/24.
//

import UIKit

import SnapKit
import Then

final class RoleChoiceView: UIView {

    // MARK: - Properties
    
    var isOwnerSelected = false
    var isStaffSelected = false
    
    // MARK: - UI Components
    
    let navigationBar = CustomNavigationView()
    private let roleChoiceTitle = UILabel()
    let ownerView = UIView()
    private let ownerStackView = UIStackView()
    private let ownerImage = UIImageView(image: .profile)
    private let ownerTitle = UILabel()
    let staffView = UIView()
    private let staffStackView = UIStackView()
    private let staffImage = UIImageView(image: .profile)
    private let staffTitle = UILabel()
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

private extension RoleChoiceView {

    func setUI() {
        backgroundColor = .backgroundBara
    }
    
    func setStyle() {
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        roleChoiceTitle.do {
            $0.text = I18N.OnboardingRegister.roleChoiceTitle
            $0.textColor = .gray7
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .fontBara(.heading)
            $0.asLineHeight(.heading)
        }
        
        [ownerView, staffView].forEach({
            $0.backgroundColor = .whiteBara
            $0.setRoundBorder(borderColor: .gray3, borderWidth: 2, cornerRadius: 12)
        })
        
        ownerTitle.do {
            $0.text = I18N.OnboardingRegister.roleChoiceOwnerTitle
        }
        
        staffTitle.do {
            $0.text = I18N.OnboardingRegister.roleChoiceStaffTitle
        }
        
        [ownerStackView, staffStackView].forEach({
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .center
        })
        
        [ownerTitle, staffTitle].forEach({
            $0.textColor = .gray4
            $0.font = .fontBara(.body1)
            $0.asLineHeight(.body1)
        })
    }
    
    func setHierarchy() {
        ownerStackView.addArrangedSubviews(ownerImage, ownerTitle)
        staffStackView.addArrangedSubviews(staffImage, staffTitle)
        ownerView.addSubview(ownerStackView)
        staffView.addSubview(staffStackView)
        addSubviews(navigationBar, roleChoiceTitle, ownerView, staffView, nextButton)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        roleChoiceTitle.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        [ownerView, staffView].forEach({
            $0.snp.makeConstraints {
                $0.top.equalTo(roleChoiceTitle.snp.bottom).offset(40)
                $0.width.equalTo((SizeLiterals.Screen.screenWidth - 65) / 2)
                $0.height.equalTo(SizeLiterals.Screen.screenHeight <= 812 ? 160 : 190)
            }
        })
        
        ownerView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
        }
        
        staffView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
        }
        
        [ownerStackView, staffStackView].forEach({
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        })
        
        [ownerImage, staffImage].forEach({
            $0.snp.makeConstraints {
                $0.size.equalTo(84)
            }
        })
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-14)
            $0.centerX.equalToSuperview()
        }
    }
    
    func updateChoiceView() {
        ownerView.layer.borderColor = isOwnerSelected ? UIColor.blueBara.cgColor : UIColor.gray1.cgColor
        ownerTitle.textColor = isOwnerSelected ? .blueBara : .gray2
        
        staffView.layer.borderColor = isStaffSelected ? UIColor.blueBara.cgColor : UIColor.gray1.cgColor
        staffTitle.textColor = isStaffSelected ? .blueBara : .gray2
        
        if !(isOwnerSelected || isStaffSelected) {
            ownerView.layer.borderColor = UIColor.gray3.cgColor
            ownerTitle.textColor = .gray4
            
            staffView.layer.borderColor = UIColor.gray3.cgColor
            staffTitle.textColor = .gray4
        }
    }

    func updateButton() {
        nextButton.isEnabled = isOwnerSelected || isStaffSelected
    }
}

extension RoleChoiceView {
    
    func ownerViewTapped() {
        isOwnerSelected.toggle()
        isStaffSelected = false
        updateChoiceView()
        updateButton()
    }
    
    func staffViewTapped() {
        isStaffSelected.toggle()
        isOwnerSelected = false
        updateChoiceView()
        updateButton()
    }
}
