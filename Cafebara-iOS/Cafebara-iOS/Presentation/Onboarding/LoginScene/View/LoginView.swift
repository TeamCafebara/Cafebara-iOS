//
//  LoginView.swift
//  Cafebara-iOS
//
//  Created by 방민지 on 3/13/24.
//

import UIKit

import AuthenticationServices
import Then
import SnapKit

final class LoginView: UIView {
    
    // MARK: - Properties
    
    var timer: Timer?
    var currentPageIndex: Int = 0
    var completion: (() -> Void)?
    
    // MARK: - UI Components
    
    let loginCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let loginPageControl = UIPageControl()
    let totalPages = 3
    let cellWidth: CGFloat = SizeLiterals.Screen.screenWidth
    let loginButton = ASAuthorizationAppleIDButton(type: .continue, style: .white)
    let testButton = UIButton()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setStyle()
        setHierarchy()
        setLayout()
        setRegisterCell()
        startAutoScroll()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension LoginView {
    func setUI() {
        self.backgroundColor = .backgroundBara
    }
    
    func setStyle() {
        loginCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth, height: 327)
            layout.collectionView?.isPagingEnabled = true
            layout.collectionView?.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.isUserInteractionEnabled = false
            $0.frame = .zero
            $0.collectionViewLayout = layout
            $0.decelerationRate = .fast
            $0.contentOffset = CGPoint(x: SizeLiterals.Screen.screenWidth, y: 0)
        }
        
        loginPageControl.do {
            $0.currentPage = 0
            $0.numberOfPages = 3
            $0.isUserInteractionEnabled = false
            $0.currentPageIndicatorTintColor = .gray3
            $0.pageIndicatorTintColor = .gray1
        }
        
        loginButton.do {
            $0.setRoundBorder(borderColor: .black, borderWidth: 1, cornerRadius: 6)
        }
    }
    
    func setHierarchy() {
        addSubviews(loginCollectionView,
                    loginPageControl,
                    loginButton)
    }
    
    func setLayout() {
        loginCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(SizeLiterals.Screen.screenHeight * 36 / 667)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth)
            $0.height.equalTo(327)
        }
        
        loginPageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginCollectionView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 38 / 667)
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(19)
            $0.top.equalTo(loginPageControl.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 147 / 667)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(14)
        }
    }
    
    func setRegisterCell() {
        LoginCollectionViewCell.register(target: loginCollectionView)
    }
    
    func startAutoScroll() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.scrollToNextPage()
        }
    }
    
    func scrollToNextPage() {
        let nextPageIndex = (currentPageIndex + 1) % totalPages
        scrollToPage(at: nextPageIndex)
    }
    
    func scrollToPage(at index: Int) {
        loginCollectionView.scrollToItem(at: IndexPath(item: index, section: 0),
                                         at: .centeredHorizontally,
                                         animated: true)
        currentPageIndex = index
        updatePageControl()
    }
    
    func updatePageControl() {
        loginPageControl.currentPage = currentPageIndex
    }
}

extension LoginView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loginPageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}
