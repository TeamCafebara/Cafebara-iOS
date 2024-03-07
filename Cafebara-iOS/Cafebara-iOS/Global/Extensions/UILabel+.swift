//
//  UILabel+.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/02/23.
//

import UIKit

extension UILabel {
    
    /// font 변경
    func asFont(targetString: String, font: UIFont) {
        let originText = text ?? ""
        let attributedString = NSMutableAttributedString(string: originText)
        let range = (originText as NSString).range(of: targetString, options: .caseInsensitive)
        attributedString.addAttribute(.font, value: font, range: range)
        attributedText = attributedString
    }
    
    /// color 변경
    func asColor(targetString: String, color: UIColor) {
        let originText = text ?? ""
        let attributedString = NSMutableAttributedString(string: originText)
        let range = (originText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
    
    /// font, color 둘 다 변경
    func asFontColor(targetString: String, font: UIFont, color: UIColor) {
        let originText = text ?? ""
        let attributedString = NSMutableAttributedString(string: originText)
        let range = (originText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        attributedText = attributedString
    }
    
    func asLineHeight(fontStyle: FontLevel) {
        
        let lineHeight = fontStyle.lineHeight
        print(lineHeight)
        
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}
