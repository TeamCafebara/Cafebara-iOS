//
//  CustomTextField.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/12/24.
//

import UIKit

import SnapKit
import Then

final class CustomTextField: UITextField {
    
    // MARK: - Properties
    
    @frozen
    enum TexFieldType {
        case normal
        case editing
        case correctType
        case uncorrectedType
        
        var borderColor: CGColor? {
            switch self {
            case .normal:
                return UIColor.gray1.cgColor
            case .editing:
                return UIColor.gray5.cgColor
            case .correctType:
                return UIColor.blue75.cgColor
            case .uncorrectedType:
                return UIColor.errorBara.cgColor
            }
        }
    }
    
    var textFieldStatus: TexFieldType = .normal {
        didSet {
            updateBorderColor()
        }
    }

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI("")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeHolder: String) {
        self.init()
        
        setUI(placeHolder)
    }
}

// MARK: - Extensions

extension CustomTextField {
    
    private func setUI(_ placeHolder: String) {
        self.do {
            $0.textColor = .gray7
            $0.backgroundColor = .whiteBara
            $0.font = .fontBara(.body3)
            $0.changePlaceholderColor(forPlaceHolder: "\(placeHolder)", forColor: .gray2)
            $0.layer.cornerRadius =  12
            $0.layer.borderColor = textFieldStatus.borderColor
            $0.layer.borderWidth = 1
            $0.addPadding(left: 16)
            $0.clearButtonMode = .whileEditing
        }
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 52 / 667)
        }
    }
    
    private func updateBorderColor() {
        self.layer.borderColor = textFieldStatus.borderColor
    }
    
    internal override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.x = bounds.width - rect.width - 16
        return rect
    }
}
