//
//  ProfileVO.swift
//  RxLoginValidataion
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation

struct Profile: Codable {
    var user: UserProfile
}

struct UserProfile: Codable {
    /// photoURL
    var photo: String
//    var followers: [String]
//    var following: [String]
    var email: String
    var username: String
    var id: String
}
