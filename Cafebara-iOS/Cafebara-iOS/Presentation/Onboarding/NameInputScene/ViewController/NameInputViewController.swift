//
//  NameInputViewController.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/12/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

final class NameInputViewController: UIViewController {
    
    // MARK: - Properties
    
    private var onboardingViewModel: OnboardingRegisterViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let nameInputView = NameInputView()
    
    // MARK: - Life Cycles
    
    init(viewModel: OnboardingRegisterViewModel) {
        self.onboardingViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = nameInputView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setTextField()
    }
}

// MARK: - Extensions

extension NameInputViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.nameInputView.nameInputTitle.text = onboardingViewModel.isOwner ? I18N.OnboardingRegister.nameInputOwnerTitle : I18N.OnboardingRegister.nameInputStaffTitle
        self.nameInputView.nameInputTextField.placeholder = onboardingViewModel.isOwner ? I18N.OnboardingRegister.nameInputOwnerPlaceholer : I18N.OnboardingRegister.nameInputStaffPlaceholer
        self.nameInputView.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func bindViewModel() {
        nameInputView.nextButton.rx.tap
            .bind {
                if let nameText = self.nameInputView.nameInputTextField.text {
                    self.onboardingViewModel.inputs.saveName(name: nameText)
                }
                if let navigationController = self.navigationController {
                    if self.onboardingViewModel.isOwner {
                        navigationController.pushViewController(StoreInputViewController(viewModel: self.onboardingViewModel), animated: true)
                    } else {
                        navigationController.pushViewController(InviteCodeViewController(viewModel: self.onboardingViewModel), animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    func setTextField() {
        nameInputView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.nameInputView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        nameInputView.nameInputTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] changedText in
                guard let self = self else { return }
                if changedText.isEmpty {
                    self.nameInputView.nameInputTextField.textFieldStatus = .normal
                    self.nameInputView.nextButton.isEnabled = false
                } else {
                    self.nameInputView.nameInputTextField.textFieldStatus = .editing
                    self.nameInputView.nextButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
        
        nameInputView.nameInputTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.nameInputView.nameInputTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        nameInputView.nameInputTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.nameInputView.nameInputTextField.becomeFirstResponder()
            })
            .disposed(by: disposeBag)
    }
}
