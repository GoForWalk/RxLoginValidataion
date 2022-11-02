//
//  ViewModelType.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation

protocol ViewModelType: AnyObject {
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
    
}
