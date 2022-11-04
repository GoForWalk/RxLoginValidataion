//
//  LoginUseCase.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/05.
//

import Foundation

import RxSwift

enum LoginError: Error {
    case loginFailed
    case elementMiss
}

protocol LoginUseCase {
    var loginStatus: Single<Bool>? { get set }
    func inputLoginEmail(email: String)
    func inputLoginPassword(password: String)
    func inputLogin()
}

final class LoginUseCaseImpi: LoginUseCase {
    
    private let apiService = APIService()
    
    private var email: String?
    private var password: String?
    
    var loginStatus: Single<Bool>?
    
    private let disposeBag = DisposeBag()
        
    func inputLogin() {
        loginStatus = login(email: email, password: password)
    }
    
    func inputLoginEmail(email: String) {
        self.email = email
    }
    
    func inputLoginPassword(password: String) {
        self.password = password
    }
        
    private func login(email: String?, password: String?) -> Single<Bool> {
        
        guard let email, let password else {
            return Single.create { single in
                single(.failure(LoginError.elementMiss))
                return Disposables.create()
            }
        }
        
        return apiService.login(email: email, password: password)
    }
    
}
