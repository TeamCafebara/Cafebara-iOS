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
    
}

protocol MyWorkViewModelOutputs {
    var myWorkInfoData: BehaviorSubject<MyWorkInfo> { get }
}

protocol MyWorkViewModelType {
    var inputs: MyWorkViewModelInputs { get }
    var outputs: MyWorkViewModelOutputs { get }
}

final class MyWorkViewModel: MyWorkViewModelInputs, MyWorkViewModelOutputs, MyWorkViewModelType {
    
    var inputs: MyWorkViewModelInputs { return self }
    var outputs: MyWorkViewModelOutputs { return self }
    
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
    
    
    
    init() {
        // TODO: 서버 통신 받기 이전 DTO
        let myWorkInfo: MyWorkInfo = MyWorkInfo(date: "02.14 수요일",
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
