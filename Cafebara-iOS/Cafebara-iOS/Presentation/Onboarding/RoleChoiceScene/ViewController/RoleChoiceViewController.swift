//
//  RoleChoiceViewController.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/12/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

final class RoleChoiceViewController: UIViewController {
    
    // MARK: - Properties
    
    private let onboardingViewModel = OnboardingRegisterViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let roleChoiceView = RoleChoiceView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = roleChoiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
    }
}

// MARK: - Extensions

extension RoleChoiceViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        roleChoiceView.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: false)
        }
    }

    func bindViewModel() {
        roleChoiceView.nextButton.rx.tap
            .bind {
                self.onboardingViewModel.saveRole(isOwner: self.roleChoiceView.isOwnerSelected ? true : false)
                
                let nav = NameInputViewController(viewModel: self.onboardingViewModel)
                self.navigationController?.pushViewController(nav, animated: true)
            }
            .disposed(by: disposeBag)
        
        roleChoiceView.ownerView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.roleChoiceView.ownerViewTapped()
            }
            .disposed(by: disposeBag)
        
        roleChoiceView.staffView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.roleChoiceView.staffViewTapped()
            }
            .disposed(by: disposeBag)
    }
}
