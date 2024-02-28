//
//  NSObject+.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/02/22.
//

import Foundation

extension NSObject {
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
}
