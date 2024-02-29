//
//  UIImageView+.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/02/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    /// url을 문자열로 넘겨주면 kingfisher를 통해 이미지 설정
    func kfSetImage(url: String?) {
        guard let url = url else { return }
        
        if let url = URL(string: url) {
            kf.indicatorType = .activity
            kf.setImage(with: url,
                        placeholder: nil,
                        options: [.transition(.fade(1.0))], progressBlock: nil)
        }
    }
}
