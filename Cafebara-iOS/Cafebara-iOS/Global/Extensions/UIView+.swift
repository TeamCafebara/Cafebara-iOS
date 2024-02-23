//
//  UIView+.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/02/22.
//

import UIKit

extension UIView {
    
    /// 한 번에 여러 개의 UIView 또는 UIView의 하위 클래스 객체들을 상위 UIView에 추가
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    /// UIView 의 모서리 커스텀 - 색상, 모서리 두께, 둥근 정도
    func setRoundBorder(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }
}
