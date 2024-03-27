//
//  MyWorkViewModel.swift
//  Cafebara-iOS
//
//  Created by 강민수 on 3/14/24.
//

import UIKit

import RxSwift
import RxRelay
import Moya

protocol MyWorkViewModelInputs {
    func saveReplaceWorkerIndexPath(indexPath: IndexPath)
}

protocol MyWorkViewModelOutputs {
    var myWorkInfoData: BehaviorSubject<MyWorkInfo> { get }
    var workerNameData: BehaviorSubject<[String]> { get }
    var alertTitle: PublishRelay<(String, String)> { get }
}

protocol MyWorkViewModelType {
    var inputs: MyWorkViewModelInputs { get }
    var outputs: MyWorkViewModelOutputs { get }
}

final class MyWorkViewModel: MyWorkViewModelInputs, MyWorkViewModelOutputs, MyWorkViewModelType {
    
    var inputs: MyWorkViewModelInputs { return self }
    var outputs: MyWorkViewModelOutputs { return self }
    
    private let disposeBag = DisposeBag()
    
    var replaceWorkerIndexPath: IndexPath?
    
    // input
    
    func saveReplaceWorkerIndexPath(indexPath: IndexPath) {
        self.replaceWorkerIndexPath = indexPath
        workerNameData
            .subscribe(onNext: { [weak self] nameData in
                self?.alertTitle.accept((nameData[indexPath.row] + I18N.MyWork.addAlertTitle, nameData[indexPath.row]))
            })
            .disposed(by: disposeBag)
    }
    
    // output
    // TODO: 서버 통신시 PublishSubject로 변경하기
    var myWorkInfoData = BehaviorSubject<MyWorkInfo>(value: MyWorkInfo(
        date: "",
        workKeyword: "",
        workKeywordTextColor: "",
        workKeywordBackColor: "",
        startTime: "",
        endTiem: "",
        name: ""
    ))
    
    var workerNameData = BehaviorSubject<[String]>(value:[])
    var alertTitle = PublishRelay<(String, String)>()
    
    init() {
        // TODO: 서버 통신 받기 이전 DTO
        let myWorkInfo: MyWorkInfo = MyWorkInfo(
            date: "02.14 수요일",
            workKeyword: "오픈",
            workKeywordTextColor: "#1F9BB6",
            workKeywordBackColor: "#EAFBFA",
            startTime: "9:00",
            endTiem: "13:00",
            name: "강민수")
        myWorkInfoData.onNext(myWorkInfo)
        
        let workerNameInfo: [String] = ["강민수1", "강민수2", "강민수3", "강민수4", "강민수5", "강민수6", "강민수7", "고아라", "김가현", "방민지", "김보연"]
        workerNameData.onNext(workerNameInfo)
    }
}

extension MyWorkViewModel {
}
