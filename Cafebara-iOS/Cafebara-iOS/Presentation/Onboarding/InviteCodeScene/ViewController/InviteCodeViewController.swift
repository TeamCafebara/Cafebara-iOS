//
//  InviteCodeViewController.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/14/24.
//

import UIKit

import Then
import RxSwift
import RxCocoa
import RxGesture

final class InviteCodeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: OnboardingRegisterViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let inviteCodeView = InviteCodeView()
    
    // MARK: - Life Cycles
    
    init(viewModel: OnboardingRegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = inviteCodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setTextField()
    }
}

// MARK: - Extensions

extension InviteCodeViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        inviteCodeView.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
        inviteCodeView.inviteCodeTitle.text = viewModel.isOwner ? I18N.OnboardingRegister.ownerInviteCodeTitle :  I18N.OnboardingRegister.staffInviteCodeTitle
        inviteCodeView.setComponent(isOwner: viewModel.isOwner)
    }

    func bindViewModel() {
        inviteCodeView.codeCertifyButton.rx.tap
            .bind {
                self.viewModel.inputs.certifyInviteCode(code: self.inviteCodeView.codeInputTextField.text ?? "")
            }
            .disposed(by: disposeBag)
        
        inviteCodeView.nextButton.rx.tap
            .bind {
                let nav = RegisterCompleteViewController(viewModel: self.viewModel)
                self.navigationController?.pushViewController(nav, animated: true)
            }
            .disposed(by: disposeBag)
        
        inviteCodeView.codePasteView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                UIPasteboard.general.string = self.inviteCodeView.ownerInviteCodeLabel.text
                self.inviteCodeView.codePasteToast.isHidden = false
            }
            .disposed(by: disposeBag)
        
        inviteCodeView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.inviteCodeView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.isCertified
            .subscribe(onNext: { isSuccess in
                self.inviteCodeView.isCertifyLabel.text = isSuccess ? I18N.OnboardingRegister.isCertifyLabelSuccess : I18N.OnboardingRegister.isCertifyLabelFail
                self.inviteCodeView.isCertifyLabel.textColor = isSuccess ? .blue75 : .errorBara
                self.inviteCodeView.isCertifyLabel.isHidden = false
                self.inviteCodeView.codeInputTextField.textFieldStatus = isSuccess ? .correctType : .uncorrectedType
                if isSuccess {
                    self.inviteCodeView.codeCertifyButton.do {
                        $0.isEnabled = false
                        $0.setBackgroundColor(.blue10, for: .disabled)
                        $0.layer.borderColor = UIColor.blue25.cgColor
                        $0.setTitleColor(.blue25, for: .disabled)
                    }
                    self.inviteCodeView.codeInputTextField.isUserInteractionEnabled = false
                    self.inviteCodeView.nextButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setTextField() {
        inviteCodeView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.inviteCodeView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        inviteCodeView.codeInputTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] changedText in
                guard let self = self else { return }
                if changedText.isEmpty {
                    self.inviteCodeView.codeInputTextField.textFieldStatus = .normal
                    self.inviteCodeView.codeCertifyButton.isEnabled = false
                } else {
                    self.inviteCodeView.codeInputTextField.textFieldStatus = .editing
                    self.inviteCodeView.codeCertifyButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
        
        inviteCodeView.codeInputTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.inviteCodeView.codeInputTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        inviteCodeView.codeInputTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.inviteCodeView.codeInputTextField.becomeFirstResponder()
            })
            .disposed(by: disposeBag)
    }
}
