//
//  MyWorkViewModel.swift
//  Cafebara-iOS
//
//  Created by 강민수 on 3/14/24.
//

import UIKit

import RxSwift
import Moya

protocol MyWorkViewModelInputs {
    func saveReplaceWorkerName(name: String)
}

protocol MyWorkViewModelOutputs {
    var myWorkInfoData: BehaviorSubject<MyWorkInfo> { get }
    var workerNameData: BehaviorSubject<[String]> { get }
}

protocol MyWorkViewModelType {
    var inputs: MyWorkViewModelInputs { get }
    var outputs: MyWorkViewModelOutputs { get }
}

final class MyWorkViewModel: MyWorkViewModelInputs, MyWorkViewModelOutputs, MyWorkViewModelType {
    
    var inputs: MyWorkViewModelInputs { return self }
    var outputs: MyWorkViewModelOutputs { return self }
    
    var replaceWorkerName: String = ""
    
    // input
    
    func saveReplaceWorkerName(name: String) {
        self.replaceWorkerName = name
    }
    
    // output
    // TODO: 서버 통신시 PublishSubject로 변경하기
    var myWorkInfoData = BehaviorSubject<MyWorkInfo>(value: MyWorkInfo(
        date: "02.14 수요일",
        workKeyword: "오픈",
        workKeywordTextColor: "#1F9BB6",
        workKeywordBackColor: "#EAFBFA",
        startTime: "9:00",
        endTiem: "13:00",
        name: "강민수"
    ))
    
    var workerNameData = BehaviorSubject<[String]>(value:["강민수1", "강민수2", "강민수3", "강민수4", "강민수5", "강민수6", "강민수7", "고아라", "김가현", "방민지", "김보연"])
    
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
    }
}

extension MyWorkViewModel {
    
}
