//
//  CustomTextField.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/12/24.
//

import UIKit

import SnapKit

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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeHolder: String) {
        self.init()
        
        setUI(placeHolder: placeHolder)
    }
}

// MARK: - Extensions

extension CustomTextField {
    
    private func setUI(placeHolder: String) {
        self.textColor = .gray7
        self.backgroundColor = .whiteBara
        self.font = .fontBara(.body3)
        self.changePlaceholderColor(forPlaceHolder: "\(placeHolder)", forColor: .gray2)
        self.layer.cornerRadius =  12
        self.layer.borderColor = textFieldStatus.borderColor
        self.layer.borderWidth = 1
        self.addPadding(left: 16)
        self.clearButtonMode = .whileEditing
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
