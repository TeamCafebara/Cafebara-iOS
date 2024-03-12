//
//  RoleChoiceViewController.swift
//  Cafebara-iOS
//
//  Created by 고아라 on 3/12/24.
//

import UIKit

final class RoleChoiceViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let roleChoiceView = RoleChoiceView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = roleChoiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setUI()
        bindViewModel()
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension RoleChoiceViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        roleChoiceView.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: false)
        }
    }

    func bindViewModel() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        
    }
}

// MARK: - Network

extension RoleChoiceViewController {

    func getAPI() {
        
    }
}
