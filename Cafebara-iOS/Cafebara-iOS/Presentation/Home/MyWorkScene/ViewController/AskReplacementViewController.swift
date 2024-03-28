//
//  AskReplacementViewController.swift
//  Cafebara-iOS
//
//  Created by 강민수 on 3/25/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

final class AskReplacementViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: MyWorkViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let askReplacementView = AskReplacementView()
    
    // MARK: - Life Cycles
    
    init(viewModel: MyWorkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = askReplacementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setDelegate()
    }
}

// MARK: - Extensions

extension AskReplacementViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        askReplacementView.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func bindViewModel() {
        viewModel.outputs.myWorkInfoData
            .bind { [weak self] data in
                self?.askReplacementView.configureView(data: data)
            }
            .disposed(by: disposeBag)
        viewModel.outputs.workerNameData
            .bind { [weak self] data in
                self?.askReplacementView.configureView(nameData: data)
            }
            .disposed(by: disposeBag)
        viewModel.outputs.alertTitle
            .bind { [weak self] title, name in
                self?.askReplacementView.alertview.configureView(title: title, name: name)
            }
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        askReplacementView.nameDropDownView.delegate = self
        askReplacementView.alertview.delegate = self
        
        askReplacementView.askButton.rx.tap
            .bind { [weak self] _ in
                self?.askReplacementView.alertview.isHidden = false
            }
            .disposed(by: disposeBag)
    }
}

extension AskReplacementViewController: DropDownTappedDelegate {
    func dropDownCellTapped(indexPath: IndexPath) {
        askReplacementView.askButton.isEnabled = true
        viewModel.inputs.saveReplaceWorkerIndexPath(indexPath: indexPath)
    }
}

extension AskReplacementViewController: AlertTappedDelegate {
    func leftButtonTapped() {
        askReplacementView.alertview.isHidden = true
    }
    
    func rightButtonTapped() {
        // TODO: 캘린더 메인화면에 토스트메시지 띄우기 + 통신 연결
        navigationController?.popToRootViewController(animated: true)
    }
}
