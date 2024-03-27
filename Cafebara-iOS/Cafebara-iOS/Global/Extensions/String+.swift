//
//  String+.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/17/24.
//

import UIKit

extension String {
    
    var containsEmoji: Bool {
        for scalar in unicodeScalars where scalar.properties.isEmoji {
            return true
        }
        return false
    }
}
