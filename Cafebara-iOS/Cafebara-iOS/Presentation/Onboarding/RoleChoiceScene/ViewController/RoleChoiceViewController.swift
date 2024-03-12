//
//  RoleChoiceViewController.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/12/24.
//

import UIKit

import RxSwift
import RxCocoa

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
        
        getAPI()
        setUI()
        bindViewModel()
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension RoleChoiceViewController {

    func setUI() {
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
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        
    }
}

// MARK: - Network

extension RoleChoiceViewController {

    func getAPI() {
        
    }
}
