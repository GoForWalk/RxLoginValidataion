//
//  APIService.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation

protocol APIServiceType {
    
}

struct APIService: APIServiceType {
    
    /// POST - URLSessionDataTask(signup)
    func signup(nickName: String, email: String, password: String) {
        
        let signup = Endpoint.signup(nickName: nickName, email: email, password: password)
        
        do {
            
            let json = signup.params
            
            // paramaters를 JSON으로 encode.
            let requestBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            
            // URLRequest 선언
            var request = URLRequest(url: signup.url)
            
            // URLRequest Method 선언
//            request.httpMethod = HTTPMethod.post.rawValue
            request.httpMethod = "POST"
            
            // header 설정
//            signup.headers.forEach { (key, value) in
//                request.addValue(value, forHTTPHeaderField: key)
//            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
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
    
    func login() {
        
    }
    
    func profile() {
        
    }
    
}
