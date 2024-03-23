//
//  MyWorkInfoView.swift
//  Cafebara-iOS
//
//  Created by 강민수 on 3/19/24.
//

import UIKit

import SnapKit
import Then

final class MyWorkInfoView: UIView {

    // MARK: - Properties
    
    enum MyWorkViewType {
        case MyWork
    }
    
    // MARK: - UI Components
    
    private let dateLabel = UILabel()
    private let workTimeTitleLabel = UILabel()
    private let workKeywordLabel = CustomPaddingLabel(padding: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10))
    private let workTimeStackView = UIStackView()
    private let workStartTimeLabel = UILabel()
    private let swungDashLabel = UILabel()
    private let workEndTimeLabel = UILabel()
    private let workerTitleLabel = UILabel()
    private let workerView = UIView()
    private let workerNameLabel = UILabel()
    
    // MARK: - Life Cycles
    
    init(type: MyWorkViewType) {
        super.init(frame: .zero)
        
        setUI()
        setStyle()
        setHierarchy()
        setLayout()
        
        switch type {
        case .MyWork:
            break
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension MyWorkInfoView {

    func setUI() {
        self.do {
            $0.backgroundColor = .whiteBara
            $0.setRoundBorder(borderColor: .gray1,
                              borderWidth: 1,
                              cornerRadius: 12)
        }
    }

    func setStyle() {
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
        
        workerView.do {
            $0.backgroundColor = .whiteBara
            $0.setRoundBorder(borderColor: .gray1,
                              borderWidth: 1,
                              cornerRadius: 8)
        }
        
        workerNameLabel.do {
            $0.font = .fontBara(.body4)
            $0.asLineHeight(.body4)
            $0.textColor = .gray7
        }
    }
    
    func setHierarchy() {
        self.addSubviews(dateLabel,
                         workTimeTitleLabel,
                         workKeywordLabel,
                         workTimeStackView,
                         workerTitleLabel,
                         workerView)
        workTimeStackView.addArrangedSubviews(workStartTimeLabel,
                                              swungDashLabel,
                                              workEndTimeLabel)
        workerView.addSubview(workerNameLabel)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(232)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
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
        
        workerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(174)
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(38)
            $0.width.equalTo(206)
        }
        
        workerNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
    }
}

extension MyWorkInfoView {

    func configureView(data: MyWorkInfo) {
        dateLabel.text = data.date
        workKeywordLabel.text = data.workKeyword
        workKeywordLabel.textColor = UIColor(hex: data.workKeywordTextColor)
        workKeywordLabel.backgroundColor = UIColor(hex: data.workKeywordBackColor)
        workStartTimeLabel.text = data.startTime
        workEndTimeLabel.text = data.endTiem
        workerNameLabel.text = data.name
    }
}
