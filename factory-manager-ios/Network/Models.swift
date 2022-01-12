//
//  Models.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 09.01.2022.
//

import Foundation

struct userModel : Encodable, Decodable {
    let login: String
    let password: String
    let role: String
}

struct userLoginBody : Encodable {
    let login: String
    let password: String
}

struct userLoginRequstModel: Decodable {
    let accessToken: String
    let tokenType: String
}

struct ApiError: Decodable {
    let errors: Dictionary<String, [String]>
}
