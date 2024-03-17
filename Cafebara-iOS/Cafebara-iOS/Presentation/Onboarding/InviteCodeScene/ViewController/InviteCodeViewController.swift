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
    }
}

// MARK: - Extensions

extension InviteCodeViewController {

    func setUI() {
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
}
