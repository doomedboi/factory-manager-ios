//
//  CoreDataManager.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 10.01.2022.
//

import Foundation


class CoreDataManager {
    static let shared = CoreDataManager()
    
    public let kUserTokenKey = "CoreDataManager.kUserTokenKey"
    
    var userToken: String? {
        get { return UserDefaults.standard.string(forKey: kUserTokenKey) }
        set { UserDefaults.standard.set(newValue, forKey: kUserTokenKey) }
    }
    
    public func removeToken() {
        UserDefaults.standard.removeObject(forKey: kUserTokenKey)
    }
}
