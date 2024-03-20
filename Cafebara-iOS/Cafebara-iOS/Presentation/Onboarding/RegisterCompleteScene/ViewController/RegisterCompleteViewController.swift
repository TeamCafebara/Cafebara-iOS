//
//  RegisterCompleteViewController.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/18/24.
//

import UIKit

import RxSwift
import RxCocoa
import UserNotifications

final class RegisterCompleteViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: OnboardingRegisterViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let registerCompleteView = RegisterCompleteView()
    
    // MARK: - Life Cycles
    
    init(viewModel: OnboardingRegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = registerCompleteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
    }
}

// MARK: - Extensions

extension RegisterCompleteViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.registerCompleteView.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func bindViewModel() {
        registerCompleteView.startButton.rx.tap
            .bind {
                self.requestPermission()
            }
            .disposed(by: disposeBag)
    }
}

extension RegisterCompleteViewController: UNUserNotificationCenterDelegate {
    
    func requestPermission() {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { didAllow, error in
            print(didAllow)
            print(error ?? "")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }
    
    /// TODO: 푸시알림 허용창에서 허용을 눌렀을때 homeVC로 가기 위한 코드
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let applicationState = UIApplication.shared.applicationState
        if applicationState == .active || applicationState == .inactive || applicationState == .background {
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                  let keyWindow = windowScene.windows.first else {
//                return
//            }
//            let homeVC = HomeViewController()
//            keyWindow.rootViewController = UINavigationController(rootViewController: homeVC)
        }
        completionHandler()
    }
}
