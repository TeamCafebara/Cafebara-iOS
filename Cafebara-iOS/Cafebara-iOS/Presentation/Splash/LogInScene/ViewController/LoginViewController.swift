//
//  LoginViewController.swift
//  Cafebara-iOS
//
//  Created by 방민지 on 3/13/24.
//

import UIKit

import AuthenticationServices
import RxSwift
import RxCocoa


final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let loginView = LoginView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setTarget()
    }
}

// MARK: - Extensions

extension LoginViewController {
    func bindViewModel() {
        viewModel.outputs.imageData
            .bind(to: loginView.loginCollectionView.rx
                .items(cellIdentifier: LoginCollectionViewCell.className,
                       cellType: LoginCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model: model)
            }
                       .disposed(by: disposeBag)
    }
    
    func setTarget() {
        loginView.loginButton.addTarget(self, action: #selector(tapAppleLogin), for: .touchUpInside)
    }
    
    @objc func tapAppleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
