//
//  CustomTabBar.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/03/11.
//

import UIKit

import SnapKit
import Then

enum TabBarItem: CaseIterable {
    
    case home, todo, schedule, work, mypage

    // 선택되지 않은 탭
    var normalItem: UIImage? {
        switch self {
        case .home:
            return UIImage(resource: .icHomeInactive)
        case .todo:
            return UIImage(resource: .icTodoInactive)
        case .schedule:
            return UIImage(resource: .icCalenderInactive)
        case .work:
            return UIImage(resource: .icWorkInactive)
        case .mypage:
            return UIImage(resource: .icMypageInactive)
        }
    }
    
    // 선택된 탭
    var selectedItem: UIImage? {
        switch self {
        case .home:
            return UIImage(resource: .icHomeInactive)
        case .todo:
            return UIImage(resource: .icTodoInactive)
        case .schedule:
            return UIImage(resource: .icCalenderInactive)
        case .work:
            return UIImage(resource: .icWorkInactive)
        case .mypage:
            return UIImage(resource: .icMypageInactive)
        }
    }
    
    // 탭 별 제목
    var itemTitle: String? {
        switch self {
        case .home: return I18N.Common.tabBarhome
        case .todo: return I18N.Common.tabBarToDo
        case .schedule: return I18N.Common.tabBarSchedule
        case .work: return I18N.Common.tabBarWork
        case .mypage: return I18N.Common.tabBarMyPage
        }
    }
    
    // 탭 별 전환될 화면 -> 나중에 하나씩 추가
    var targetViewController: UIViewController {
        switch self {
        case .home: return ViewController()
        case .todo: return ViewController() //TodoViewController()
        case .schedule: return ViewController() //ScheduleViewController()
        case .work: return ViewController() //WorkViewController()
        case .mypage: return ViewController() //MyPageViewController()
        }
    }
}
