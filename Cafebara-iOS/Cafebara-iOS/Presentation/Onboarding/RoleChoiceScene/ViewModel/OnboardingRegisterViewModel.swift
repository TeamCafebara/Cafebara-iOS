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
    func saveStore(store: String)
    func certifyInviteCode(code: String)
}

protocol OnboardingRegisterViewModelOutputs {
    var isCertified: PublishSubject<Bool> { get }
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
    var store: String = ""
    
    // input
    
    func saveRole(isOwner: Bool) {
        self.isOwner = isOwner
    }
    
    func saveName(name: String) {
        self.name = name
    }
    
    func saveStore(store: String) {
        self.store = store
    }
    
    func certifyInviteCode(code: String) {
        print("✅✅✅입력코드✅✅✅")
        print(code)
        print("✅✅✅입력코드✅✅✅")
        isCertified.onNext(true)
    }
    
    // output
    
    var isCertified: PublishSubject<Bool> = PublishSubject<Bool>()
    
    init() {

    }
}

extension OnboardingRegisterViewModel {
}
