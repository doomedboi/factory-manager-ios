//
//  helpers.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 09.01.2022.
//

import Foundation


class NetworkHelper {
    
    static func getApiErrors(errors: Dictionary<String, [String]>) -> String? {
        var errorsString = ""
        for (_, values) in errors.reversed() {
            for e in values {
                errorsString += e + "\n"
            }
        }
        return errorsString
    }
    
    static func getFullImagePath(domain: String = "http://109.196.164.54/", localPath: String) -> URL? {
        return URL(string: domain + localPath)
    }
}
