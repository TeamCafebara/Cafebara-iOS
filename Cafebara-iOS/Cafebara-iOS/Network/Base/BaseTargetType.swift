//
//  BaseTargetType.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 2/29/24.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
}
