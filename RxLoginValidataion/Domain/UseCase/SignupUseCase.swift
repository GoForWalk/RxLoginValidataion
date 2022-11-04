//
//  SignupUseCase.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation

import RxSwift
import RxRelay


final class SignupUseCase {
    
    private let apiService = APIService()
    
    let signupErrorState = BehaviorSubject<SignupValidationState>(value: .empty)
    
    private var nickName: String?
    private var email: String?
    private var password: String?
    
    let nickNameVaildation = BehaviorSubject(value: false)
    let emailValidation = BehaviorSubject(value: false)
    let passwordVaildation = BehaviorSubject(value: false)
    
    private let disposeBag = DisposeBag()
    
    func signupAccount() {
        guard let nickName, let email, let password else {
            signupErrorState.onNext(.empty)
            return
        }
        
        apiService.signup(nickName: nickName, email: email, password: password)
    }
    
    func nickNameValidate(nickName: String) {
        
        guard nickName.count > 0 else {
            nickNameVaildation.onNext(false)
            return }
        
        self.nickName = nickName
        nickNameVaildation.onNext(true)
    }
    
    func emailValidate(email: String) {
        
        switch validateEmailRegEx(email) {
        case true:
            self.email = email
            emailValidation.onNext(true)
        case false:
            emailValidation.onNext(false)
        }
    }
    
    func passwordValidate(password: String) {
        
        guard password.count > 7 else {
            passwordVaildation.onNext(false)
            return
        }
        
        self.password = password
        passwordVaildation.onNext(true)
    }
    
    private func validateEmailRegEx(_ string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return string.range(of: emailRegEx, options: .regularExpression) != nil
    }
    
}
