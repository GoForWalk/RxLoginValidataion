//
//  LoginViewController.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

final class SignupViewController: BaseViewContoller {

    private let signupView = SignupView()
    //프로토콜은 추상화 하는 형태로 사용 하시고, init로 뷰모델 주입해보시면
    private var viewModel = SignupViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = signupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bind() {
        
        let input = SignupViewModel.Input(
            nickname: signupView.nickNameTextField.rx.text,
            email: signupView.emailTextField.rx.text,
            password: signupView.passwordTextField.rx.text,
            postButton: signupView.postButton.rx.tap
        )
        
        let output = viewModel.transform(input)
        
        output.nickNameValidate
            .asDriver(onErrorJustReturn: false)
            .drive(with: signupView.emailTextField) { textField, bool in
                textField.isHidden = !bool
            }
            .disposed(by: disposeBag)
        
        output.emailValidate
            .asDriver(onErrorJustReturn: false)
            .drive(with: signupView.passwordTextField) { textField, bool in
                textField.isHidden = !bool
            }
            .disposed(by: disposeBag)
        
        output.passwordValidate
            .asDriver(onErrorJustReturn: false)
            .drive(with: signupView.postButton) { button, bool in
                button.isHidden = !bool
            }
            .disposed(by: disposeBag)
        
        output.nicknameVaildateMsg
            .asDriver(onErrorJustReturn: "")
            .drive(signupView.nickNameValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.emailValidateMsg
            .asDriver(onErrorJustReturn: "")
            .drive(signupView.emailValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.passwordValidateMsg
            .asDriver(onErrorJustReturn: "")
            .drive(signupView.passwordValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        
    }

}
