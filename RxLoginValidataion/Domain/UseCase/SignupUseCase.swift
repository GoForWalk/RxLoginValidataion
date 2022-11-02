//
//  SignupUseCase.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation

import RxSwift
import RxRelay

enum SignupValidationState {
    case empty
    case emailError
    case nicknameError
    case passwordError
    case haveEmail
}

final class SignupUseCase {
    
    private let apiService = APIService()
    
    let signupErrorState = BehaviorSubject<SignupValidationState>(value: .empty)
    var nickName: String?
    var email: String?
    var password: String?
    
    private let disposeBag = DisposeBag()
    
    func signupAccount() {
        guard let nickName, let email, let password else { signupErrorState.onNext(.empty)
            return
        }
        
        apiService.signup(nickName: nickName, email: email, password: password)
    }
    
    func nickNameValidate(nickName: String) -> PublishSubject<Bool> {
        let nickNameVaildation = PublishSubject<Bool>()
        
        guard nickName.count > 0 else {
            nickNameVaildation.onNext(false)
            return nickNameVaildation }
        
        self.nickName = nickName
        nickNameVaildation.onNext(true)
        
        return nickNameVaildation
    }
    
    func emailValidate(email: String) -> PublishSubject<Bool> {
        let emailValidation = PublishSubject<Bool>()
        
        
    }
    
    func passwordValidate(password: String) -> PublishSubject<Bool> {
        
        
    }
    
}
