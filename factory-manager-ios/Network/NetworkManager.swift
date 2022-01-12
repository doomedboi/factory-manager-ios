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
    
    static func me(completion: @escaping ((userModel) -> Void)) {
        let components = URLComponents(string: "http://109.196.164.54/api/v1/me")!
        
        var request = URLRequest(url: components.url!)

        var headerPayload = "Bearer "
        headerPayload += CoreDataManager.shared.userToken!
        
        request.addValue(headerPayload, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {
                    // return error here
                    return
            }
            
            do {
                let userInfo = try NetworkManager.decoder.decode(userModel.self, from: data)
                completion(userInfo)
                return
            } catch (let e) {
                print("decode error \(e)")
            }
        }
        task.resume()
    }
    
    static func cloth(complition: @escaping ([ClothModel])->(Void)) {
        let components = URLComponents(string: "http://109.196.164.54/api/v1/cloth")!
        
        var request = URLRequest(url: components.url!)

        var headerPayload = "Bearer "
        headerPayload += CoreDataManager.shared.userToken!
        
        request.addValue(headerPayload, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                return
            }
            
            do {
                let castedData = try NetworkManager.decoder.decode([ClothModel].self, from: data)
                complition(castedData)
            } catch(let e) {
                print("decode err: \(e)")
            } 
            
        }
        task.resume()
    }
    
    static func accessory(complition: @escaping ([AccessoryModel])->(Void)) {
        let components = URLComponents(string: "http://109.196.164.54/api/v1/accessory")!
        
        var request = URLRequest(url: components.url!)

        var headerPayload = "Bearer "
        headerPayload += CoreDataManager.shared.userToken!
        
        request.addValue(headerPayload, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                return
            }
            
            do {
                let castedData = try NetworkManager.decoder.decode([AccessoryModel].self, from: data)
                complition(castedData)
            } catch(let e) {
                print("decode err: \(e)")
            }
            
        }
        task.resume()
        
    }
    
    
}
