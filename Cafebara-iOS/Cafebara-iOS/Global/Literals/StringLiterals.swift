//
//  StringLiterals.swift
//  Cafebara-iOS
//
//  Created by Gahyun Kim on 2024/02/22.
//

import Foundation

enum I18N {
    
    enum Common {
        static let alertContainTitle = "대타"
        static let alertName = " 님"
        static let alertLeftTitle = "할래요"
        static let alertRightTitle = "안할래요"
        static let alertLeftTitle2 = "취소할게요"
        static let alertRightTitle2 = "보낼게요"
        static let nextButtonTitle = "다음으로"
    }
    
    enum OnboardingRegister {
        static let roleChoiceTitle = "안녕하세요!\n카페바라 시작 전 선택해 주세요"
        static let roleChoiceOwnerTitle = "사장이에요"
        static let roleChoiceStaffTitle = "직원이에요"
        static let nameInputOwnerTitle = "반가워요 사장님!\n사장님의 성함을 알려주세요"
        static let nameInputStaffTitle = "안녕하세요!\n다음으로 이름도 알려주세요"
        static let nameInputOwnerPlaceholer = "사장님의 성함을 입력해 주세요!"
        static let nameInputStaffPlaceholer = "실제 이름으로 입력해 주세요!"
        static let codeInputPlaceholder = "사장님께 공유 받은 초대코드를 입력해 주세요!"
        static let codeCertifyButtonTitle = "코드 인증"
        static let inviteCodeTitle = "반가워요!\n초대코드를 입력해 주세요"
        static let isCertifyLabelSuccess = "코드 인증 성공!"
        static let isCertifyLabelFail = "코드 인증 실패!"
    }
}
