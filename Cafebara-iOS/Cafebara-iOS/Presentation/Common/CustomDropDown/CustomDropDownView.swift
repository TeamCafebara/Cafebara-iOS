//
//  CustomDropDownView.swift
//  Cafebara-iOS
//
//  Created by 강민수 on 3/25/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import RxGesture

@frozen
enum DropDownType {
    case medium
    case large
    
    var dropDownWidth: CGFloat {
        switch self {
        case .medium:
            return 206
        case .large:
            return SizeLiterals.Screen.screenWidth - 40
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .medium:
            return 38
        case .large:
            return 42
        }
    }
}

protocol DropDownTappedDelegate: AnyObject {
    func dropDownCellTapped(indexPath: IndexPath)
}

final class CustomDropDownView: UIView {
    
    // MARK: - Properties
    
    var delegate: DropDownTappedDelegate?
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let selectedView = UIView()
    private let placeholderLabel = UILabel()
    private let selectedItemLabel = UILabel()
    private let dropDownImageView = UIImageView()
    private let dropDownTableView = UITableView()
    private var isVisibleDropDown: Bool = false
    
    var selectedViewBorderColor: UIColor = .gray2 {
        didSet {
            selectedView.setRoundBorder(borderColor: selectedViewBorderColor,
                                        borderWidth: 1,
                                        cornerRadius: 8)
        }
    }
    
    var dropDownBorderColor: UIColor = .gray2 {
        didSet {
            dropDownTableView.setRoundBorder(borderColor: dropDownBorderColor,
                                             borderWidth: 1,
                                             cornerRadius: 8)
        }
    }
    
    var font: UIFont = .fontBara(.body4) {
        didSet {
            placeholderLabel.font = font
            selectedItemLabel.font = font
        }
    }
    
    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    var placeholderColor: UIColor = .gray3 {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    var selectedItemTextColor: UIColor = .gray7 {
        didSet {
            selectedItemLabel.textColor = selectedItemTextColor
        }
    }
    
    var dataSource = [String]() {
        didSet {
            dropDownTableView.reloadData()
        }
    }
    
    // MARK: - Life Cycles

    init(type: DropDownType) {
        super.init(frame: .zero)
        
        setUI()
        setStyle(type: type)
        setHierarchy()
        setLayout(type: type)
        setRegisterCell()
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension CustomDropDownView {
    
    func setUI() {
        backgroundColor = .clear
    }
    
    func setStyle(type: DropDownType) {
        selectedView.do {
            $0.backgroundColor = .whiteBara
        }
        
        selectedItemLabel.do {
            $0.isHidden = true
        }
        
        dropDownImageView.do {
            $0.image = UIImage(resource: .icDropboxDown)
        }
        
        dropDownTableView.do {
            $0.isHidden = true
            $0.rowHeight = type.cellHeight
            $0.separatorStyle = .none
        }
    }
    
    func setHierarchy() {
        self.addSubviews(selectedView,
                         dropDownTableView)
        selectedView.addSubviews(placeholderLabel,
                                 selectedItemLabel,
                                 dropDownImageView)
    }
    
    func setLayout(type: DropDownType) {
        self.snp.makeConstraints {
            $0.height.equalTo(type.cellHeight + 144)
            $0.width.equalTo(type.dropDownWidth)
        }
        
        selectedView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(type.cellHeight)
        }
        
        dropDownTableView.snp.makeConstraints {
            $0.top.equalTo(selectedView.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        placeholderLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        selectedItemLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        dropDownImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(24)
        }
    }
    
    func setRegisterCell() {
        dropDownTableView.dataSource = self
        dropDownTableView.delegate = self
        dropDownTableView.register(CustomDropDownTableViewCell.self, forCellReuseIdentifier: "CustomDropDownTableViewCell")
    }
    
    func setDelegate() {
        selectedView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                self.isVisibleDropDown.toggle()
                
                self.dropDownTableView.isHidden = !self.isVisibleDropDown
                self.dropDownImageView.image = self.isVisibleDropDown ? UIImage(resource: .icDropboxUp) : UIImage(resource: .icDropboxDown)
            }
            
            .disposed(by: disposeBag)
        
        dropDownTableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                let cell = self.dropDownTableView.cellForRow(at: indexPath) as? CustomDropDownTableViewCell
                cell?.dropDownItemLabel.textColor = .blueBara
                cell?.backgroundColor = .blue10
                
                self.selectedItemLabel.text = self.dataSource[indexPath.row]
                self.placeholderLabel.isHidden = true
                self.selectedItemLabel.isHidden = false
                self.dropDownTableView.isHidden = true
                
                self.dropDownImageView.image = UIImage(resource: .icDropboxDown)
                
                self.isVisibleDropDown.toggle()
                self.delegate?.dropDownCellTapped(indexPath: indexPath)
            }
            .disposed(by: disposeBag)
        
        dropDownTableView.rx.itemDeselected
            .bind { [weak self] indexPath in
                let cell = self?.dropDownTableView.cellForRow(at: indexPath) as? CustomDropDownTableViewCell
                cell?.dropDownItemLabel.textColor = self?.selectedItemTextColor
                cell?.backgroundColor = .whiteBara
            }
            .disposed(by: disposeBag)
    }
}

extension CustomDropDownView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDropDownTableViewCell", for: indexPath) as? CustomDropDownTableViewCell else { return UITableViewCell() }
        
        cell.dropDownItemLabel.text = dataSource[indexPath.row]
        cell.dropDownItemLabel.font = font
        
        return cell
    }
}

extension CustomDropDownView: UITableViewDelegate {}
