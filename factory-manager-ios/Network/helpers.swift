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
}
