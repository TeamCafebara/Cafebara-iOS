//
//  CustomNavigationView.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/8/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

final class CustomNavigationView: UIView {

    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    var titleLabelText: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var isTitleLabelIncluded: Bool {
        get { !titleLabel.isHidden }
        set { titleLabel.isHidden = !newValue }
    }
    
    var isBackButtonIncluded: Bool {
        get { !backButton.isHidden }
        set { backButton.isHidden = !newValue }
    }
    
    var isMenuButtonIncluded: Bool {
        get { !menuButton.isHidden }
        set { menuButton.isHidden = !newValue }
    }
    
    var isAlarmButtonIncluded: Bool {
        get { !alarmDefaultButton.isHidden || !alarmNewButton.isHidden }
        set {
            alarmDefaultButton.isHidden = !newValue
            alarmNewButton.isHidden = !newValue
        }
    }

    var hasAlarm: Bool {
        get { !alarmNewButton.isHidden }
        set {
            alarmDefaultButton.isHidden = newValue
            alarmNewButton.isHidden = !newValue
        }
    }
    
    var isBookMarkButtonIncluded: Bool {
        get { !bookMarkButton.isHidden }
        set { bookMarkButton.isHidden = !newValue }
    }
    
    var isModifyButtonIncluded: Bool {
        get { !modifyButton.isHidden }
        set { modifyButton.isHidden = !newValue }
    }
    
    var backButtonAction: (() -> Void)?
    var menuButtonAction: (() -> Void)?
    var alarmNewButtonAction: (() -> Void)?
    var alarmDefaultButtonAction: (() -> Void)?
    var bookMarkButtonAction: (() -> Void)?
    var modifyButtonAction: (() -> Void)?
    
    // MARK: - UI Components
    
    private lazy var titleLabel = UILabel()
    private lazy var backButton = UIButton()
    private lazy var menuButton = UIButton()
    private lazy var alarmNewButton = UIButton()
    private lazy var alarmDefaultButton = UIButton()
    private lazy var bookMarkButton = UIButton()
    private lazy var modifyButton = UIButton()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setStyle()
        setHierarchy()
        setLayout()
        setButtonAction()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension CustomNavigationView {

    func setUI() {
        backgroundColor = .backgroundBara
    }
    
    func setStyle() {
        titleLabel.do {
            $0.textColor = .gray7
            $0.font = .fontBara(.title1)
        }
        
        backButton.do {
            $0.setImage(UIImage(resource: .icNaviBack44), for: .normal)
        }
        
        menuButton.do {
            $0.setImage(UIImage(resource: .icNaviMenu44), for: .normal)
        }
        
        alarmNewButton.do {
            $0.setImage(UIImage(resource: .icNaviAlarmNew44), for: .normal)
        }
        
        alarmDefaultButton.do {
            $0.setImage(UIImage(resource: .icNaviAlarmDefault44), for: .normal)
        }
        
        bookMarkButton.do {
            $0.setImage(UIImage(resource: .icNaviBookmark44), for: .normal)
        }
        
        modifyButton.do {
            $0.setImage(UIImage(resource: .icNaviModify44), for: .normal)
        }
    }
    
    func setHierarchy() {
        addSubviews(titleLabel, backButton, menuButton, alarmNewButton, alarmDefaultButton, bookMarkButton, modifyButton)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        [backButton, menuButton, alarmNewButton, alarmDefaultButton, bookMarkButton, modifyButton].forEach {
            $0.isHidden = true
            $0.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.size.equalTo(44)
            }
        }
        
        [backButton, menuButton].forEach {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(12)
            }
        }
        
        [alarmNewButton, alarmDefaultButton, bookMarkButton, modifyButton].forEach {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(12)
            }
        }
    }
    
    func setButtonAction() {
        backButton.rx.tap
            .bind {
                self.backButtonAction?()
            }
            .disposed(by: disposeBag)
        
        menuButton.rx.tap
            .bind {
                self.menuButtonAction?()
            }
            .disposed(by: disposeBag)
        
        alarmNewButton.rx.tap
            .bind {
                self.alarmNewButtonAction?()
            }
            .disposed(by: disposeBag)
        
        alarmDefaultButton.rx.tap
            .bind {
                self.alarmDefaultButtonAction?()
            }
            .disposed(by: disposeBag)
        
        bookMarkButton.rx.tap
            .bind {
                self.bookMarkButtonAction?()
            }
            .disposed(by: disposeBag)
        
        modifyButton.rx.tap
            .bind {
                self.modifyButtonAction?()
            }
            .disposed(by: disposeBag)
    }
}
