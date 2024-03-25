//
//  LoginImageDto.swift
//  Cafebara-iOS
//
//  Created by 방민지 on 3/13/24.
//

import UIKit

struct LoginImageDto {
    let image: UIImage
}

extension LoginImageDto {
    static func imageDummy() -> [LoginImageDto] {
        return [
            LoginImageDto(image: UIImage(resource: .logInImage1)),
            LoginImageDto(image: UIImage(resource: .logInImage2)),
            LoginImageDto(image: UIImage(resource: .logInImage3))
        ]
    }
}
