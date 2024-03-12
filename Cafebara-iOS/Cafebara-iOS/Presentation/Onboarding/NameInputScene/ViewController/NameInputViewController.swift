//
//  NameInputViewController.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/12/24.
//

import UIKit

import RxSwift
import RxCocoa

final class NameInputViewController: UIViewController {
    
    // MARK: - Properties
    
    private var onboardingViewModel: OnboardingRegisterViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let nameInputview = NameInputView()
    
    // MARK: - Life Cycles
    
    init(viewModel: OnboardingRegisterViewModel) {
        self.onboardingViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = nameInputview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
    }
}

// MARK: - Extensions

extension NameInputViewController {

    func setUI() {
        self.nameInputview.nameInputTitle.text = onboardingViewModel.isOwner ? I18N.OnboardingRegister.nameInputOwnerTitle : I18N.OnboardingRegister.nameInputStaffTitle
        self.nameInputview.nameInputTextField.placeholder = onboardingViewModel.isOwner ? I18N.OnboardingRegister.nameInputOwnerPlaceholer : I18N.OnboardingRegister.nameInputStaffPlaceholer
        self.nameInputview.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func bindViewModel() {
        nameInputview.nextButton.rx.tap
            .bind {
                if let nameText = self.nameInputview.nameInputTextField.text {
                    self.onboardingViewModel.inputs.saveName(name: nameText)
                }
            }
            .disposed(by: disposeBag)
    }
}
