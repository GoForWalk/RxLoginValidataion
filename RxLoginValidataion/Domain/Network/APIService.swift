//
//  APIService.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation
import Network

import RxSwift

protocol APIServiceType {
    
}

struct APIService: APIServiceType {
    
    /// POST - URLSessionDataTask(signup)
    /// 회원 가입
    func signup(nickName: String, email: String, password: String) {
        
        let signup = Endpoint.signup(nickName: nickName, email: email, password: password)
        
        do {
            
            let json = signup.params
            
            // paramaters를 JSON으로 encode.
            let requestBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            // URLRequest 선언
            var request = URLRequest(url: signup.url)
            
            // URLRequest Method 선언
            request.httpMethod = HTTPMethod.post.rawValue
            
            // header 설정
            request.addValue(HTTPHeader.json.value, forHTTPHeaderField: HTTPHeader.forHTTPHeaderField)
            
            // request
            request.httpBody = requestBody
            
            let defaultSession = URLSession(configuration: .default)
            
            defaultSession.dataTask(with: request) { data, response, error in
                
                guard error == nil else {
                    print("Error occur: error calling POST - \(String(describing: error))")
                    return
                }
                
                guard let data, let response = response as? HTTPURLResponse, (200...300).contains(response.statusCode) else {
                    print("Error: HTTP request failed \(response?.description)")
                    return
                }
                
                print(String(data: data, encoding: .utf8) ?? "No Data")
                
            }.resume()
            
            
        } catch {
            
        }
        
    }
    
    ///  POST
    ///  UserDefault에 로그인 token 경과 저장
    func login(email: String, password: String) -> Single<Bool> {
        
        return Single<Bool>.create { single in
            
            let login = Endpoint.login(email: email, password: password)
            
            let json = login.params
            let requestBody = try? JSONSerialization.data(withJSONObject: json, options: [])
            
            var request = URLRequest(url: login.url)
            request.addValue(HTTPHeader.json.value, forHTTPHeaderField: HTTPHeader.forHTTPHeaderField)
            
            request.httpBody = requestBody
            request.httpMethod = HTTPMethod.post.rawValue
            
            let defaultSession = URLSession(configuration: .default)
            
            let task = defaultSession.dataTask(with: request) { data, response, error in
                
                guard error == nil else {
                    print("Error occur: error calling POST - \(String(describing: error))")
                    single(.failure(LoginError.loginFailed))
                    return
                }
                
                guard let data, let response = response as? HTTPURLResponse, (200...300).contains(response.statusCode) else {
                    print("Error: HTTP request failed \(response?.description)")
                    single(.failure(LoginError.loginFailed))
                    return
                }
                
                let decoder = JSONDecoder()
                
                guard let token = try? decoder.decode(Login.self, from: data) else { return }
                
                print("token registered")
                UserDefaults.standard.set(token.token, forKey: UserDefaultsKey.key)
                single(.success(true))
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        
    }
    
    /// Get
    /// completionHandler
    func profile() {
        
    }
    
}
