//
//  LoginViewModel.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/04.
//

import Foundation

import RxCocoa
import RxSwift

final class LoginViewModel: ViewModelType {
    
    let loginUseCase: LoginUseCase = LoginUseCaseImpi()
    
    let disposeBag = DisposeBag()
    
    struct Input {
        var loginEmail: ControlProperty<String?>
        var loginPassword: ControlProperty<String?>
        var loginButton: ControlEvent<Void>
    }
    
    struct Output {
        var loginStatus: Single<Bool>
    }
    
    // TODO: init pattern (DI)
//    init(loginUseCase: LoginUseCase) {
//        self.loginUseCase = loginUseCase
//    }
    
    func transform(_ input: Input) -> Output {
        self.configInput(input: input, disposeBag: disposeBag)
        return Output(loginStatus: loginUseCase.loginStatus!)
    }
    
}

private extension LoginViewModel {
    
    func configInput(input: Input, disposeBag: DisposeBag) {
        
        input.loginEmail.orEmpty
            .withUnretained(self)
            .bind { vc, email in
                vc.loginUseCase.inputLoginEmail(email: email)
            }
            .disposed(by: disposeBag)
        
        input.loginPassword.orEmpty
            .withUnretained(self)
            .bind { vc, password in
                vc.loginUseCase.inputLoginPassword(password: password)
            }
            .disposed(by: disposeBag)
        
        input.loginButton
            .withUnretained(self)
            .bind { vc, _ in
                vc.loginUseCase.inputLogin()
            }
            .disposed(by: disposeBag)
        
    }
    
}
