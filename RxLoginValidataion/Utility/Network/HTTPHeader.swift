//
//  HTTPHeader.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/04.
//

import Foundation

enum HTTPHeader {
    
    static let forHTTPHeaderField: String = "Content-Type"
    
    case json
    case encodedURL
    
}

extension HTTPHeader {
    
    var value: String {
        switch self {
        case .json:
            return "application/json"
        case .encodedURL:
            return "application/x-www-form-urlencoded"
        }
    }
}
