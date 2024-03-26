//
//  AskReplacementView.swift
//  Cafebara-iOS
//
//  Created by 강민수 on 3/25/24.
//

import UIKit

import SnapKit
import Then

final class AskReplacementView: UIView {
    
    // MARK: - UI Components
    
    let navigationBar = CustomNavigationView()
    let myWorkInfoView = UIView()
    private let dateLabel = UILabel()
    private let workTimeTitleLabel = UILabel()
    private let workKeywordLabel = CustomPaddingLabel(padding: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10))
    private let workTimeStackView = UIStackView()
    private let workStartTimeLabel = UILabel()
    private let swungDashLabel = UILabel()
    private let workEndTimeLabel = UILabel()
    private let workerTitleLabel = UILabel()
    let nameDropDownView = CustomDropDownView(type: .medium)
    let askButton = CustomButton(status: false,
                                 type: .noBorder,
                                 title: I18N.MyWork.askReplacementButtonTitle)
    
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

private extension AskReplacementView {
    
    func setUI() {
        backgroundColor = .backgroundBara
    }
    
    func setStyle() {
        navigationBar.do {
            $0.isBackButtonIncluded = true
            $0.isTitleLabelIncluded = true
            $0.titleLabelText = I18N.MyWork.askReplacementNavigationTitle
        }
        
        myWorkInfoView.do {
            $0.backgroundColor = .whiteBara
            $0.setRoundBorder(borderColor: .gray1,
                              borderWidth: 1,
                              cornerRadius: 12)
        }
        
        dateLabel.do {
            $0.font = .fontBara(.title3)
            $0.asLineHeight(.title3)
            $0.textColor = .gray2
        }
        
        workTimeTitleLabel.do {
            $0.text = I18N.MyWork.workTimeTitle
            $0.font = .fontBara(.body3)
            $0.asLineHeight(.body3)
            $0.textColor = .gray5
        }
        
        workKeywordLabel.do {
            $0.font = .fontBara(.caption1)
            $0.asLineHeight(.caption1)
            $0.layer.cornerRadius = 12
            $0.layer.masksToBounds = true
        }
        
        workTimeStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }
        
        workStartTimeLabel.do {
            $0.font = .fontBara(.title3)
            $0.asLineHeight(.title3)
            $0.textColor = .gray5
        }
        
        swungDashLabel.do {
            $0.text = I18N.MyWork.swungDash
            $0.font = .fontBara(.title3)
            $0.asLineHeight(.title3)
            $0.textColor = .gray5
        }
        
        workEndTimeLabel.do {
            $0.font = .fontBara(.title3)
            $0.asLineHeight(.title3)
            $0.textColor = .gray5
        }
        
        workerTitleLabel.do {
            $0.text = I18N.MyWork.wokerTitle
            $0.font = .fontBara(.body3)
            $0.asLineHeight(.body3)
            $0.textColor = .gray5
        }
        
        nameDropDownView.do {
            $0.selectedViewBorderColor = .blueBara
            $0.dropDownBorderColor = .blue25
            $0.font = .fontBara(.body4)
            $0.placeholderColor = .gray7
            $0.selectedItemTextColor = .gray7
            $0.dataSource = ["김보연", "방민지", "고아라", "김가현"]
        }
    }
    
    func setHierarchy() {
        addSubviews(navigationBar,
                    myWorkInfoView,
                    nameDropDownView,
                    askButton)
        
        myWorkInfoView.addSubviews(dateLabel,
                                   workTimeTitleLabel,
                                   workKeywordLabel,
                                   workTimeStackView,
                                   workerTitleLabel)
        workTimeStackView.addArrangedSubviews(workStartTimeLabel,
                                              swungDashLabel,
                                              workEndTimeLabel)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        myWorkInfoView.snp.makeConstraints {
            $0.height.equalTo(232)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(18)
        }
        
        workTimeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(66)
            $0.leading.equalToSuperview().inset(18)
        }
        
        workKeywordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(94)
            $0.leading.equalToSuperview().inset(18)
        }
        
        workTimeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(95)
            $0.leading.equalTo(workKeywordLabel.snp.trailing).offset(12)
            $0.height.equalTo(22)
            $0.width.equalTo(110)
        }
        
        workerTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(146)
            $0.leading.equalToSuperview().inset(18)
        }
        
        nameDropDownView.snp.makeConstraints {
            $0.top.equalTo(workerTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(workerTitleLabel)
        }
        
        askButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-14)
            $0.centerX.equalToSuperview()
        }
    }
}

extension AskReplacementView {
    
    func configureView(data: MyWorkInfo) {
        dateLabel.text = data.date
        workKeywordLabel.text = data.workKeyword
        workKeywordLabel.textColor = UIColor(hex: data.workKeywordTextColor)
        workKeywordLabel.backgroundColor = UIColor(hex: data.workKeywordBackColor)
        workStartTimeLabel.text = data.startTime
        workEndTimeLabel.text = data.endTiem
        nameDropDownView.placeholder = data.name
    }
}
