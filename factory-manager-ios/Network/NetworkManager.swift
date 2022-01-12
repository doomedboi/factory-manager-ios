//
//  NetworkManager.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 09.01.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    
    private init() {
        NetworkManager.decoder.keyDecodingStrategy = .convertFromSnakeCase
        NetworkManager.encoder.keyEncodingStrategy = .convertToSnakeCase
        }
    
    static private func createUrlRequest(urlObj: URL, body: Data) -> URLRequest {
        var urlRequest = URLRequest(url: urlObj)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
    }
}

extension NetworkManager {
    static func login(_ body: Data,
                          completion: @escaping ((userLoginRequstModel) -> Void),
                          onError :@escaping((ApiError) -> Void)) {
        guard let url = URL(string: "http://109.196.164.54/api/v1/plane_login") else {
            print("error with url")
            return
        }
        
        NetworkManager.decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        
        let request = createUrlRequest(urlObj: url, body: body)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            
            if let res = response as? HTTPURLResponse {
                print("code \(res.statusCode)")
                switch res.statusCode {
                
                case 422:
                    do {
                        let errData = try NetworkManager.decoder.decode(ApiError.self, from: data)
                        onError(errData)
                        return
                    } catch let e {
                        print("Decode error: \(e)")
                    }
                case 200:
                    do {
                        let userData = try NetworkManager.decoder.decode(userLoginRequstModel.self, from: data)
                        completion(userData)
                        return
                    } catch let e {
                        print("Decode error: \(e)")
                    }
                
                default:
                    //  look at here
                    onError(ApiError(errors: ["lol" : ["lol2"]]))
                    return
                    
                }
            }
        }
        task.resume()
        
    }
}
