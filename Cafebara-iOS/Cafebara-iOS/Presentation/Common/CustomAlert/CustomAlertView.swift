//
//  CustomAlertView.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/8/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

enum AlertType {
    case small
    case medium
    case big
    
    var alertHeight: CGFloat {
        switch self {
        case .small:
            return SizeLiterals.Screen.screenHeight * 164 / 667
        case .medium:
            return SizeLiterals.Screen.screenHeight * 186 / 667
        case .big:
            return SizeLiterals.Screen.screenHeight * 194 / 667
        }
    }
}

protocol AlertTappedDelegate: AnyObject {
    
    func leftButtonTapped()
    func rightButtonTapped()
}

final class CustomAlertView: UIView {

    // MARK: - Properties
    
    var delegate: AlertTappedDelegate?
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let backgroundView = UIView()
    private let alertView = UIView()
    private let alertTitleLabel = UILabel()
    private let alertSubTitleLabel = UILabel()
    private lazy var leftButton = UIButton()
    private lazy var rightButton = UIButton()
    
    // MARK: - Life Cycles
    
    init(type: AlertType, title: String, subTitle: String) {
        super.init(frame: .zero)
        
        setUI()
        setAlertUI(type: type, title: title, subTitle: subTitle)
        setHierarchy()
        setLayout()
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension CustomAlertView {

    func setUI() {
        backgroundColor = .clear
    }
    
    func setAlertUI(type: AlertType, title: String, subTitle: String) {
        backgroundView.do {
            $0.backgroundColor = .black.withAlphaComponent(0.65)
        }
        
        alertView.do {
            $0.backgroundColor = .whiteBara
            $0.layer.cornerRadius = 10
        }
        
        alertTitleLabel.do {
            $0.text = title
            $0.font = .fontBara(.body1)
            $0.asLineHeight(.body1)
            $0.numberOfLines = 0
            $0.textColor = .gray7
            $0.textAlignment = .center
        }
        
        alertSubTitleLabel.do {
            $0.text = subTitle
            $0.font = .fontBara(.body4)
            $0.asLineHeight(.body4)
            $0.numberOfLines = 0
            $0.textColor = .gray4
            $0.textAlignment = .center
        }
        
        if title.contains("대타") {
            leftButton.do {
                $0.setTitle("취소할게요", for: .normal)
                $0.setTitleColor(.gray4, for: .normal)
                $0.titleLabel?.font = UIFont.fontBara(.body3)
                $0.titleLabel?.asLineHeight(.body3)
                $0.backgroundColor = .whiteBara
                $0.makeRoundBorder(cornerRadius: 4, borderWidth: 1, borderColor: .gray2)
            }
            rightButton.do {
                $0.setTitle("보낼게요", for: .normal)
                $0.setTitleColor(.whiteBara, for: .normal)
                $0.titleLabel?.font = UIFont.fontBara(.body3)
                $0.titleLabel?.asLineHeight(.body3)
                $0.backgroundColor = .blueBara
                $0.makeRoundBorder(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
            }
            
            if let range = title.range(of: " 님") {
                let name = title[title.startIndex..<range.lowerBound]
                alertTitleLabel.asColor(targetString: String(name), color: .blueBara)
            }
        } else {
            leftButton.do {
                $0.setTitle("할래요", for: .normal)
                $0.setTitleColor(.gray4, for: .normal)
                $0.titleLabel?.font = UIFont.fontBara(.body3)
                $0.titleLabel?.asLineHeight(.body3)
                $0.backgroundColor = .whiteBara
                $0.makeRoundBorder(cornerRadius: 4, borderWidth: 1, borderColor: .gray2)
            }
            rightButton.do {
                $0.setTitle("안할래요", for: .normal)
                $0.setTitleColor(.whiteBara, for: .normal)
                $0.titleLabel?.font = UIFont.fontBara(.body3)
                $0.titleLabel?.asLineHeight(.body3)
                $0.backgroundColor = .blueBara
                $0.makeRoundBorder(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
            }
        }
        
        alertView.snp.makeConstraints {
            $0.height.equalTo(type.alertHeight)
        }
    }
    
    func setHierarchy() {
        alertView.addSubviews(alertTitleLabel, alertSubTitleLabel, leftButton, rightButton)
        addSubviews(backgroundView, alertView)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 63)
        }
        
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 32 / 667)
            $0.centerX.equalToSuperview()
        }
        
        alertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 8 / 667)
            $0.centerX.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 22 / 667)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 117) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 44 / 667)
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 22 / 667)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 117) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 44 / 667)
        }
    }
    
    func setDelegate() {
        leftButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.delegate?.leftButtonTapped()
            }
            .disposed(by: disposeBag)
        
        rightButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.delegate?.rightButtonTapped()
            }
            .disposed(by: disposeBag)
    }
}
