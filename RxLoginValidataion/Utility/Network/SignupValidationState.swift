//
//  SignupValidationState.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/05.
//

import Foundation

enum SignupValidationState {
    case empty
    case emailError
    case nicknameError
    case passwordError
    case haveEmail
}

extension SignupValidationState {
    var errorDescription: String {
        switch self {
        case .empty:
            return "비어있는 값이 있습니다."
        case .emailError:
            return "이메일을 다시 한번 확인해 주세요."
        case .nicknameError:
            return "닉네임을 다시 한번 확인해 주세요."
        case .passwordError:
            return "비밀번호를 다시 한번 확인해 주세요."
        case .haveEmail:
            return "이미 가입된 이메일 입니다."
        }
    }
}
