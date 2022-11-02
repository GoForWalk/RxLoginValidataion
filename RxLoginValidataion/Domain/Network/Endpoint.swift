//
//  Endpoint.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation

enum Endpoint {
    
    case signup(nickName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
    
}

extension Endpoint {
    
    var url: URL {
        let baseURL = "http://api.memolease.com"
        switch self {
        case .signup:
            return URL(string: "\(baseURL)/api/v1/users/signup")!
        case .login:
            return URL(string: "\(baseURL)/api/v1/users/login")!
        case .profile:
            return URL(string: "\(baseURL)/api/v1/users/me")!
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .signup, .login:
            return ["Content-Type":"application/x-www-form-urlencoded"]
        case .profile:
            return ["Content-Type":"application/x-www-form-urlencoded", "Authorization":"\(UserDefaults.standard.string(forKey: "token") ?? "")"]
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .signup(let nickName, let email, let password):
            return [
                "userName": "\(nickName)",
                "email": "\(email)",
                "password": "\(password)"
            ]
        case .login(let email, let password):
            return [
                "email": "\(email)",
                "password": "\(password)"
            ]
        default:
            return ["":""]
        }
    }
}
