//
//  OnboardingRegisterViewModel.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/12/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

protocol OnboardingRegisterViewModelInputs {
    func saveRole(isOwner: Bool)
    func saveName(name: String)
}

protocol OnboardingRegisterViewModelOutputs {

}

protocol OnboardingRegisterViewModelType {
    
    var inputs: OnboardingRegisterViewModelInputs { get }
    var outputs: OnboardingRegisterViewModelOutputs { get }
}

final class OnboardingRegisterViewModel: OnboardingRegisterViewModelInputs, OnboardingRegisterViewModelOutputs, OnboardingRegisterViewModelType {
    
    var inputs: OnboardingRegisterViewModelInputs { return self }
    var outputs: OnboardingRegisterViewModelOutputs { return self }
    
    var isOwner: Bool = false
    var name: String = ""
    
    // input
    
    func saveRole(isOwner: Bool) {
        self.isOwner = isOwner
    }
    
    func saveName(name: String) {
        self.name = name
    }
    
    init() {

    }
}

extension OnboardingRegisterViewModel {
    
}
