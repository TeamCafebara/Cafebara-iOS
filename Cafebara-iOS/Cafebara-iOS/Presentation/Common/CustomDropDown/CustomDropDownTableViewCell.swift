//
//  CustomDropDownTableViewCell.swift
//  Cafebara-iOS
//
//  Created by 강민수 on 3/26/24.
//

import UIKit

import SnapKit
import Then

final class CustomDropDownTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    let dropDownItemLabel = UILabel()
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.backgroundColor = .whiteBara
        dropDownItemLabel.textColor = .gray7
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension CustomDropDownTableViewCell {
    
    func setUI() {
        self.do {
            $0.backgroundColor = .whiteBara
            $0.selectionStyle = .none
        }
    }
    
    func setHierarchy() {
        self.addSubview(dropDownItemLabel)
    }
    
    func setLayout() {
        dropDownItemLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
