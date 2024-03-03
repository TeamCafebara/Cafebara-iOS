//
//  APIConstant.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 2/29/24.
//

import Foundation

enum NetworkHeaderKey: String {
    case deviceToken = "deviceToken"
    case accessToken = "accesstoken"
    case refreshToken = "refreshToken"
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

enum APIConstants {
    
    static let accept: String = "Accept"
    static let auth: String = "x-auth-token"
    static let applicationJSON = "application/json"
    static var deviceToken: String = ""
    static var jwtToken: String = ""
    static var refreshToken: String = ""
    
    // MARK: - Header
    
    static var headerWithOutToken: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON
        ]
    }
    
    static var headerWithDeviceToken: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: URLConstant.bearer + APIConstants.deviceToken
        ]
    }
    
    static var headerWithAuthorization: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: URLConstant.bearer + APIConstants.jwtToken
        ]
    }
    
    static var headerWithRefresh: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: URLConstant.bearer + APIConstants.jwtToken,
            NetworkHeaderKey.refreshToken.rawValue: URLConstant.bearer + APIConstants.refreshToken
        ]
    }
}
