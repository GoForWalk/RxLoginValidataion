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
        let nicknameVaildate: BehaviorRelay<Bool>
        let emailValidate: BehaviorRelay<Bool>
        let passwordValidate: BehaviorRelay<Bool>
        let postButtonValidate: BehaviorRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        return createOutput(input: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        
        input.nickname.orEmpty
            .withUnretained(self)
            .subscribe {
                $0.signupUseCase.nickNameValidate(nickName: $1)
            }
            .disposed(by: disposeBag)
            
            
        input.email.orEmpty
            
        
        
        input.password.orEmpty
        
        input.postButton.
    }
    
    private func createOutput(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        
        
        
        return output
    }
    
}
