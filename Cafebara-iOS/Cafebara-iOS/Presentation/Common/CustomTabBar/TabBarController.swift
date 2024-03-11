//
//  TabBarController.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/03/11.
//

import UIKit

import SnapKit
import Then

// MARK: - Tab Bar

final class TabBarController: UITabBarController {
    
    var customTabBar = CustomTabBar()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(customTabBar, forKey: "tabBar")
        
        setupStyle()
        addTabBarController()
    }
}

// MARK: - Private Extensions

private extension TabBarController {
    func setupStyle() {
        view.backgroundColor = .backgroundBara
        tabBar.backgroundColor = .whiteBara
    }
    
    func addTabBarController() {
        var viewControllers = [UIViewController]()
        for item in TabBarItem.allCases {
            let currentViewController = createViewController(
                title: item.itemTitle ?? "",
                image: item.normalItem ?? .add,
                selectedImage: item.selectedItem ?? .add,
                viewController: item.targetViewController,
                inset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            )
            viewControllers.append(currentViewController)
        }
        setViewControllers(viewControllers, animated: false)
    }
    
    func createViewController(title: String,
                              image: UIImage,
                              selectedImage: UIImage,
                              viewController: UIViewController,
                              inset: UIEdgeInsets? ) -> UIViewController {
        let currentViewController = viewController
        let tabbarItem = UITabBarItem(
            title: title,
            image: image.withRenderingMode(.alwaysOriginal),
            selectedImage: selectedImage.withRenderingMode(.alwaysOriginal)
        )
        if let inset {
            tabbarItem.imageInsets = inset
        }
        
        // title이 선택되지 않았을 때 폰트, 색상 설정
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.fontBara(.caption1),
            .foregroundColor: UIColor.gray2
        ]
        
        // title이 선택되었을 때 폰트, 색상 설정
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.fontBara(.caption1),
            .foregroundColor: UIColor.orangeBara
        ]
        
        tabbarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        tabbarItem.setTitleTextAttributes(normalAttributes, for: .normal)
        tabbarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        currentViewController.tabBarItem = tabbarItem
        
        return currentViewController
    }
}

// Custom Tab Bar
final class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height += 11
        return size
    }
}
