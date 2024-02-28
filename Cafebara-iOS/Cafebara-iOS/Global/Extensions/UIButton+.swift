//
//  UIButton+.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/02/23.
//

import UIKit

extension UIButton {
    
    /// Button 모서리 커스텀 - 색상, 모서리 두께, 둥근 정도
    func makeRoundBorder(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor ) {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
