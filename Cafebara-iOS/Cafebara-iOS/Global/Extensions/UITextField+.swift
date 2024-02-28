//
//  UITextField+.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/02/23.
//

import UIKit

extension UITextField {
    
    /// 텍스트필드 안쪽에 패딩 추가
    /// - Parameter left: 왼쪽에 추가할 패딩 너비
    /// - Parameter right: 오른쪽에 추가할 패딩 너비
    func addPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let leftPadding = left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 0))
            leftViewMode = .always
        }
        if let rightPadding = right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 0))
            rightViewMode = .always
        }
    }
    
    /// Placeholder의 색상을 바꿔주는 메서드
    func changePlaceholderColor(forPlaceHolder: String, forColor: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: forPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor: forColor])
    }
}
