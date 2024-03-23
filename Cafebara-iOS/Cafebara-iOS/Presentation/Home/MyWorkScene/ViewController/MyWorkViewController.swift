//
//  MyWorkViewController.swift
//  Cafebara-iOS
//
//  Created by 강민수 on 3/14/24.
//

import UIKit

import RxSwift
import RxCocoa

final class MyWorkViewController: UIViewController {
    
    // MARK: - Properties
    private let myWorkViewModel = MyWorkViewModel() // 내부에서 만들면 안됨. init주입받아야함.
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let myWorkView = MyWorkView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = myWorkView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setDelegate()
    }
}

// MARK: - Extensions

extension MyWorkViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        myWorkView.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: false)
        }
    }

    func bindViewModel() {
        myWorkViewModel.outputs.myWorkInfoData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.myWorkView.myWorkInfoView.configureView(data: data)
            })
            .disposed(by: disposeBag)
        
    }
    
    func setDelegate() {
//        myWorkView.askButton.rx.tap {
//
//        }
    }
}
