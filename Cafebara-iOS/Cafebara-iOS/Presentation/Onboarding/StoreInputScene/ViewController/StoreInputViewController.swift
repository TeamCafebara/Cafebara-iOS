//
//  StoreInputViewController.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/17/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

final class StoreInputViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: OnboardingRegisterViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let storeInputView = StoreInputView()
    
    // MARK: - Life Cycles
    
    init(viewModel: OnboardingRegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = storeInputView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setTextField()
    }
}

// MARK: - Extensions

extension StoreInputViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.storeInputView.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func bindViewModel() {
        storeInputView.nextButton.rx.tap
            .bind {
                if let storeText = self.storeInputView.storeInputTextField.text {
                    self.viewModel.inputs.saveStore(store: storeText)
                }
                let nav = InviteCodeViewController(viewModel: self.viewModel)
                self.navigationController?.pushViewController(nav, animated: true)
            }
            .disposed(by: disposeBag)
        
        storeInputView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.storeInputView.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
    
    func checkStoreCount(_ store: String) -> Bool {
       return store.count > 18 || store.containsEmoji
   }
    
    func setTextField() {
        storeInputView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.storeInputView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        storeInputView.storeInputTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .map(checkStoreCount(_:))
            .subscribe(onNext: { bool in
                if bool {
                    self.storeInputView.storeInputTextField.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
        
        storeInputView.storeInputTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] changedText in
                guard let self = self else { return }
                if changedText.isEmpty {
                    self.storeInputView.storeInputTextField.textFieldStatus = .normal
                    self.storeInputView.nextButton.isEnabled = false
                } else {
                    self.storeInputView.storeInputTextField.textFieldStatus = .editing
                    self.storeInputView.nextButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
        
        storeInputView.storeInputTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.storeInputView.storeInputTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        storeInputView.storeInputTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.storeInputView.storeInputTextField.becomeFirstResponder()
            })
            .disposed(by: disposeBag)
    }
}
