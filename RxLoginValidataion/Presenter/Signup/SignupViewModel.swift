//
//  SignupViewModel.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation
import RxSwift
import RxCocoa

final class SignupViewModel: ViewModelType {
    
    private let signupUseCase = SignupUseCase()
    private let disposeBag = DisposeBag()
    
    struct Input {
        let nickname: ControlProperty<String?>
        let email: ControlProperty<String?>
        let password: ControlProperty<String?>
        let postButton: ControlEvent<Void>
    }
    
    struct Output {
        let nicknameVaildateMsg = BehaviorRelay<String>(value: "")
        let emailValidateMsg = BehaviorRelay<String>(value: "")
        let passwordValidateMsg = BehaviorRelay<String>(value: "")
        
        let nickNameValidate = BehaviorRelay<Bool>(value: false)
        let emailValidate = BehaviorRelay<Bool>(value: false)
        let passwordValidate = BehaviorRelay<Bool>(value: false)
        let postButtonValidate = BehaviorRelay<Bool>(value: false)
    }
    
    func transform(_ input: Input) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        return returnOutput(input: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        
        input.nickname.orEmpty
            .withUnretained(self)
            .subscribe {
                $0.signupUseCase.nickNameValidate(nickName: $1)
            }
            .disposed(by: disposeBag)
            
        input.email.orEmpty
            .withUnretained(self)
            .subscribe {
                $0.signupUseCase.emailValidate(email: $1)
            }
            .disposed(by: disposeBag)
        
        input.password.orEmpty
            .withUnretained(self)
            .subscribe {
                $0.signupUseCase.passwordValidate(password: $1)
            }
            .disposed(by: disposeBag)
        
        input.postButton
            .withUnretained(self)
            .subscribe { [weak self] _ in
                self?.signupUseCase.signupAccount()
            }
            .disposed(by: disposeBag)
    }
    
    private func returnOutput(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        self.signupUseCase.nickNameVaildation
            .subscribe { bool in
                output.nickNameValidate.accept(bool)

                if !bool {
                    output.nicknameVaildateMsg.accept("닉네임을 입력해 주세요.")
                } else {
                    output.nicknameVaildateMsg.accept("")
                }
            }
            .disposed(by: disposeBag)
        
        self.signupUseCase.emailValidation
            .subscribe { bool in
                output.emailValidate.accept(bool)
                
                if !bool {
                    output.emailValidateMsg.accept("이메일을 다시 확인해주세요.")
                } else {
                    output.emailValidateMsg.accept("")
                }
            }
            .disposed(by: disposeBag)

        self.signupUseCase.passwordVaildation
            .subscribe { bool in
                output.passwordValidate.accept(bool)

                if !bool {
                    output.passwordValidateMsg.accept("8자 이상 입력해주세요.")
                } else {
                    output.passwordValidateMsg.accept("")
                }
            }
            .disposed(by: disposeBag)
        
        
//        self.signupUseCase.signupErrorState
//            .subscribe { validationState in
//
//            }
//            .disposed(by: disposeBag)
        
        return output
    }
    
}
