//
//  CustomButton.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/9/24.
//

import UIKit

import SnapKit
import Then

enum CustomButtonType {
    case noBorder
    case hasBorder
}

final class CustomButton: UIButton {
    
    // MARK: - Properties
    
    override var isEnabled: Bool {
        didSet {
            updateBorderColor()
        }
    }

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(status: Bool, type: CustomButtonType, title: String) {
        self.init()
        
        setButtonUI(status: status, type: type, title: title)
        setLayout()
    }
}

// MARK: - Extensions

private extension CustomButton {

    func setButtonUI(status: Bool, type: CustomButtonType, title: String) {
        self.isEnabled = status
        self.layer.cornerRadius = 10
        self.setTitle(title, for: .normal)
        
        switch type {
        case .noBorder:
            self.setBackgroundColor(.gray1, for: .disabled)
            self.setBackgroundColor(.blueBara, for: .normal)
            self.setTitleColor(.gray2, for: .disabled)
            self.setTitleColor(.white, for: .normal)
        case .hasBorder:
            self.setBackgroundColor(.gray1, for: .disabled)
            self.setTitleColor(.gray3, for: .disabled)
            self.setBackgroundColor(.blue10, for: .normal)
            self.setTitleColor(.blueBara, for: .normal)
            self.layer.borderWidth = 2
            self.layer.borderColor = isEnabled ? UIColor.blue50.cgColor : UIColor.gray2.cgColor
        }
        self.titleLabel?.font = .fontBara(.body2)
        self.titleLabel?.asLineHeight(.body2)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 54 / 667)
        }
    }
    
    func updateBorderColor() {
        self.layer.borderColor = isEnabled ? UIColor.blue50.cgColor : UIColor.gray2.cgColor
    }
}
