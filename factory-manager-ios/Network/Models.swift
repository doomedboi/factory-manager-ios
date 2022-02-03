//
//  Models.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 09.01.2022.
//

import Foundation

struct userModel : Encodable, Decodable {
    let login: String
    let name: String
    let role: Int
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

struct ClothModel: Encodable, Decodable {
    let article: Int
    let name: String
    let color: String
    let print: String
    let image: String
    let composition: String
    let width: Float
    let price: Float
}

struct AccessoryModel: Decodable {
    let article: Int
    let name: String
    let type: String
    let width: Int
    let length: Int
    let weight: Float
    let image: String
    let price: Float
    let kgAcceptable: Bool
}

struct AccessoryDecommission: Encodable {
    let article: Int
    let amount: Int
}

struct ProductModel: Decodable {
    let id: Int
    let article: Int
    let name: String
    let width: Int
    let length: Int
    let image: String
    let comment: String
    let price: Float
    let size: Int
    let clothes: [ClothModel]
    let accessories: [AccessoryModel]
    let changedDate: String?
    let previous: Int?
}

struct accessoryAmountResponse: Decodable {
    let article: Int
    let amount: Int?
}

struct ProductsContainerModel: Decodable {
    let product: ProductModel
}

struct OrderModel: Decodable {
    let id: Int?
    let creationDate: String
    let completionDate: String?
    let stage: Int?
    let manager: userModel
    let customer: userModel
    let cost: Float
    let products: [ProductsContainerModel]
}


struct ClothArticleModel: Decodable {
    let number: Int
    let article: Int
    let length: Double
}
