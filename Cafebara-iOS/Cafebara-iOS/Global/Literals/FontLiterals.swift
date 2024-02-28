//
//  FontLiterals.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/02/22.
//

import UIKit

enum FontName: String {
    case SUITBold = "SUIT-Bold"
    case SUITMedium = "SUIT-Medium"
    case SUITRegular = "SUIT-Regular"
    case SUITSemiBold = "SUIT-SemiBold"
}

enum FontLevel {
    case heading
    
    case title1
    case title2
    case title3
    
    case body1
    case body2
    case body3
    case body4
    
    case caption1
    case caption2
}

extension FontLevel {
    
    var fontWeight: String {
        switch self {
        case .heading, .title1, .title3, .caption1:
            return FontName.SUITSemiBold.rawValue
        case .title2, .caption2:
            return FontName.SUITMedium.rawValue
        case .body1, .body3, .body4:
            return FontName.SUITRegular.rawValue
        case .body2:
            return FontName.SUITBold.rawValue
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .heading:
            return 25
        case .title1:
            return 22
        case .title2:
            return 20
        case .title3, .body1:
            return 17
        case .body2, .body3:
            return 15
        case .body4:
            return 13
        case .caption1:
            return 12
        case .caption2:
            return 11
        }
    }
}

extension UIFont {
    static func fontBara(_ fontLevel: FontLevel) -> UIFont {
        let font = UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
        return font
    }
}
