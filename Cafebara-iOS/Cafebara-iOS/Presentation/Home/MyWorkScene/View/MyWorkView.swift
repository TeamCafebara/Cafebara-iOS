//
//  MyWorkView.swift
//  Cafebara-iOS
//
//  Created by 강민수 on 3/14/24.
//

import UIKit

import SnapKit
import Then

final class MyWorkView: UIView {

    // MARK: - Properties
    
    // MARK: - UI Components
    
    let navigationBar = CustomNavigationView()
    let myWorkInfoView = MyWorkInfoView(type: .MyWork)
    let askButton = CustomButton(status: true,
                                 type: .noBorder,
                                 title: I18N.MyWork.askChangingWorkButtonTitle)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension MyWorkView {

    func setUI() {
        backgroundColor = .backgroundBara
    }

    func setStyle() {
        navigationBar.do {
            $0.isBackButtonIncluded = true
            $0.isTitleLabelIncluded = true
            $0.titleLabelText = I18N.MyWork.myWorkNavigationTitle
        }
    }
    
    func setHierarchy() {
        addSubviews(navigationBar,
                    myWorkInfoView,
                    askButton)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        myWorkInfoView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        askButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-14)
            $0.centerX.equalToSuperview()
        }
    }
}

extension MyWorkView {

    func configureView() {
        
    }
}
