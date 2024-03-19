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
    private let myWorkViewModel = MyWorkViewModel()
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
        myWorkViewModel.myWorkInfoObservable
            .map { $0.date }
            .bind(to: myWorkView.myWorkInfoView.dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        myWorkViewModel.myWorkInfoObservable
            .map { $0.workKeyword }
            .bind(to: myWorkView.myWorkInfoView.workKeywordLabel.rx.text)
            .disposed(by: disposeBag)
        
        myWorkViewModel.myWorkInfoObservable
            .map { $0.workKeywordTextColor }
            .map { hexString in
                UIColor(hex: hexString, alpha: 1.0)
            }
            .bind(to: myWorkView.myWorkInfoView.workKeywordLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        myWorkViewModel.myWorkInfoObservable
            .map { $0.workKeywordBackColor }
            .map { hexString in
                UIColor(hex: hexString, alpha: 1.0)
            }
            .bind(to: myWorkView.myWorkInfoView.workKeywordLabel.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        myWorkViewModel.myWorkInfoObservable
            .map { $0.startTime }
            .bind(to: myWorkView.myWorkInfoView.workStartTimeLabel.rx.text)
            .disposed(by: disposeBag)
        
        myWorkViewModel.myWorkInfoObservable
            .map { $0.endTiem }
            .bind(to: myWorkView.myWorkInfoView.workEndTimeLabel.rx.text)
            .disposed(by: disposeBag)
        
        myWorkViewModel.myWorkInfoObservable
            .map { $0.name }
            .bind(to: myWorkView.myWorkInfoView.workerNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        
    }
}
