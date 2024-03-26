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
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.askReplacementView.configureView(data: data)
            })
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        askReplacementView.nameDropDownView.delegate = self
        
        askReplacementView.askButton.rx.tap
            .bind {
                // TODO: 대타요청팝업뷰
            }
            .disposed(by: disposeBag)
    }
}

extension AskReplacementViewController: DropDownTappedDelegate {
    func dropDownCellTapped(indexPath: IndexPath) {
        askReplacementView.askButton.isEnabled = true
    }
}
