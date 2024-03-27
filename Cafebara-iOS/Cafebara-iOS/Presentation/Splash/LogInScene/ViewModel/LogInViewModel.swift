//
//  LogInViewModel.swift
//  Cafebara-iOS
//
//  Created by 방민지 on 3/13/24.
//

import UIKit

import Moya
import RxSwift
import RxCocoa


protocol LoginViewModelInputs {
}

protocol LoginViewModelOutputs {
    var imageData: BehaviorRelay<[LoginImageDto]> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

final class LoginViewModel: LoginViewModelInputs, LoginViewModelOutputs, LoginViewModelType {
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
 
    // output
    
    var imageData: BehaviorRelay<[LoginImageDto]> = BehaviorRelay<[LoginImageDto]>(value: LoginImageDto.imageDummy())
    
    init() {
    }
}

extension LoginViewModel {
}
