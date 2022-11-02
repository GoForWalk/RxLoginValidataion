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

    let signupView = SignupView()
    var viewModel = SignupViewModel()
    
    
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
        
        
        
        
    }

}
