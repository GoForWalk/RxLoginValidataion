//
//  LoginViewController.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: BaseViewContoller {

    let loginView = LoginView()
    let viewModel = LoginViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func bind() {
        
        let input = LoginViewModel.Input(
            loginEmail: loginView.emailTextField.rx.text,
            loginPassword: loginView.passwordTextField.rx.text,
            loginButton: loginView.loginButton.rx.tap
        )
        
        let output = viewModel.transform(input)
        
        loginView.signUpButton.rx.tap
            .share()
            .observe(on: MainScheduler.instance)
            .take(1)
            .subscribe { [weak self] _ in
                let signupVC = SignupViewController()
                
                self?.present(signupVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.loginStatus
            .observe(on: MainScheduler.instance)
            .subscribe { bool in
                if bool {
                    // TODO: 화면 변경
                }
            } onFailure: { error in
                guard let loginError = error as? LoginError else { return }
                
                switch loginError {
                case .loginFailed:
                    // Toast 실패 이유
                    return
                    
                case .elementMiss:
                    // Toast 실패 이유
                    return
                }
            }
            .disposed(by: disposeBag)

        
    }

}
