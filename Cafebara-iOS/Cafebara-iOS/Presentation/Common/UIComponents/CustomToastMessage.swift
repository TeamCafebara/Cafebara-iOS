//
//  CustomToastMessage.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/9/24.
//

import UIKit

import SnapKit
import Then

final class CustomToastMessage: UIView {

    // MARK: - Properties
    
    override var isHidden: Bool {
        didSet {
            if !isHidden {
                setAnimation()
            }
        }
    }
    
    private var labelWidth: CGFloat = 0
    
    // MARK: - UI Components
    
    private let toastLabel = UILabel()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init()
        
        setToastUI(title: title)
        setHierarchy()
        setLayout()
    }
}

// MARK: - Extensions

private extension CustomToastMessage {

    func setToastUI(title: String) {
        self.backgroundColor = .gray8.withAlphaComponent(0.75)
        self.layer.cornerRadius = 20
        self.labelWidth = labelSize(text: title)
        
        toastLabel.do {
            $0.text = title
            $0.textColor = .whiteBara
            $0.font = .fontBara(.caption1)
            $0.asLineHeight(.caption1)
        }
    }
    
    func labelSize(text: String) -> CGFloat {
        let size = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontBara(.caption1)]).width + 48
        return size
    }
    
    func setHierarchy() {
        self.addSubview(toastLabel)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(labelWidth)
            $0.height.equalTo(40)
        }
        
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setAnimation() {
        UIView.animate(withDuration: 0.8, delay: 0.7, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: {_ in
            self.isHidden = true
            self.alpha = 1.0
        })
    }
}
