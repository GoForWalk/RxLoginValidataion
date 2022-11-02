//
//  LoginView.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import UIKit

import SnapKit

final class SignupView: BaseView {
    
    let nickNameTextField: UITextField = {
        let textField =  UITextField()
        textField.placeholder = "닉네임을 입력하세요."
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField =  UITextField()
        textField.placeholder = "이메일을 입력하세요."
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField =  UITextField()
        textField.placeholder = "비밀번호를 입력하세요."
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    let nickNameValidationLabel: UILabel = {
        let label =  UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    let emailValidationLabel: UILabel = {
        let label =  UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    let passwordValidationLabel: UILabel = {
        let label =  UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 10)
        return label
    }()
        
    let postButton: UIButton = {
        let button =  UIButton()
        button.setTitle("SignIn", for: .normal)
        button.backgroundColor = .green
        return button
    }()
        
    override func setConfigure() {
        super.setConfigure()
        [nickNameTextField, emailTextField, passwordTextField, nickNameValidationLabel, emailValidationLabel, passwordValidationLabel, postButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        nickNameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameValidationLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }

        emailValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailValidationLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }

        passwordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }

        postButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
    }
    
    
}
