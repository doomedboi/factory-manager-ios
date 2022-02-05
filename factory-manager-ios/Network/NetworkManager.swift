//
//  NetworkManager.swift
//  factory-manager-ios
//
//  Created by soFuckingHot on 09.01.2022.
//

import Foundation
import CoreVideo

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let baseURL = "https://Sewing.mrfox131.software/api/v1"
    
    static let encoder = JSONEncoder()
    static let decoder: JSONDecoder = ({
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    })()
    
    
    private init() {
        NetworkManager.decoder.keyDecodingStrategy = .convertFromSnakeCase
        NetworkManager.encoder.keyEncodingStrategy = .convertToSnakeCase
        }
    
    static private func createUrlRequest(urlObj: URL) -> URLRequest {
        var urlRequest = URLRequest(url: urlObj)
        if let token = CoreDataManager.shared.userToken {
            urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
    }
    
    static private func createGetRequest(url: URL, body: Data? = nil) -> URLRequest {
        var req = createUrlRequest(urlObj: url)
        
        req.httpMethod = "GET"
        req.httpBody = body
        
        return req
    }
    
    static private func createPostRequest(url: URL, body: Data? = nil) -> URLRequest {
        var req = createUrlRequest(urlObj: url)
        
        req.httpMethod = "POST"
        req.httpBody = body
        
        return req
    }
    
    static private func createPatchRequest(url: URL, body: Data? = nil) -> URLRequest {
        var req = createUrlRequest(urlObj: url)
    
        req.httpMethod = "PATCH"
        req.httpBody = body
        
        return req
    }
}

extension NetworkManager {
    static func login(_ body: Data,
                          completion: @escaping ((userLoginRequstModel) -> Void),
                          onError :@escaping((ApiError) -> Void)) {
        guard let url = URL(string: baseURL + "/plane_login") else {
            print("error with url")
            return
        }
        
        let request = createPostRequest(url: url, body: body)
        
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
                    onError(ApiError(errors: ["lol" : ["Проверьте логин и(или) пароль"]]))
                    return
                    
                }
            }
        }
        task.resume()
        
    }
    
    static func me(completion: @escaping ((userModel) -> Void)) {
        let url = URL(string: baseURL + "/me")!
        
        let request = createGetRequest(url: url, body: nil)
        
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
        let url = URL(string: baseURL + "/cloth")!
        
        let request = createGetRequest(url: url, body: nil)
        
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
        let url = URL(string: baseURL + "/accessory")!
        
        let request = createGetRequest(url: url, body: nil)
        
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
    
    
    static func product(complition: @escaping ([ProductModel])->(Void)) {
        guard let url = URL(string: baseURL + "/product") else {
            return
        }
        
       let request = createGetRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                return
            }
            
            do {
                let castedData = try NetworkManager.decoder.decode([ProductModel].self, from: data)
                complition(castedData)
                print(castedData)
            } catch(let e) {
                print("decode err: \(e)")
            }
            
        }
        task.resume()
    }
    
    
    
    static func order(complition: @escaping ([OrderModel])->(Void)) {
        guard let url = URL(string: baseURL + "/order") else {return}
        
        let request = createGetRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                return
            }
            
            do {
                let castedData = try NetworkManager.decoder.decode([OrderModel].self, from: data)
                complition(castedData)
                print(castedData)
            } catch(let e) {
                print("decode err: \(e)")
            }
            
        }
        task.resume()
    }
    
    static func getPreviousProducts(article: Int, size: Int, complition: @escaping ([ProductModel])-> (Void)) {
        guard let url = URL(string: baseURL + "/product/v2/\(article)/\(size)/previous") else { return }
        
        let request = createGetRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                return
            }
            
            do {
                let castedData = try NetworkManager.decoder.decode([ProductModel].self, from: data)
                complition(castedData)
                print("DATA:")
                print(castedData)
            } catch(let e) {
                print("decode err: \(e)")
            }
            
        }
        task.resume()
        
    }
    
    
    static func accessoryDecommission(article: Int, quanity: Int, complition: @escaping (Bool)-> (Void)) {
        print(article, quanity)
        guard let url = URL(string: baseURL + "/accessory/\(article)?quantity=\(quanity)") else {
            print("BAD URL")
            return
        }
        print(url)
        let request = createPatchRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            print(response.statusCode)
            if response.statusCode == 200 {
                print("Succes")
                complition(true)
            } else {
                complition(false)
            }
            
        }
        task.resume()
        
    }
    
    static func accessoryInKg(article: Int, amount: Double, complition: @escaping (Bool)-> (Void)) {
        guard let url = URL(string: baseURL + "/accessory_in_kg/\(article)?amount=\(amount)") else {
            return
        }
        
        let request = createPatchRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            print(response.statusCode)
            if response.statusCode == 200 {
                print("Succes")
                complition(true)
            } else {
                complition(false)
            }
            
        }
        task.resume()
    }
    
    static func getClothByArticle(article: Int, complition: @escaping ([ClothArticleModel])->(Void)) {
        guard let url = URL(string: baseURL + "/cloth/\(article)") else { return }
        
        let request = createGetRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let castedData = try NetworkManager.decoder.decode([ClothArticleModel].self, from: data)
                complition(castedData)
                print("DATA:")
                print(castedData)
            } catch(let e) {
                print("decode err: \(e)")
            }
            
        }
        task.resume()
        
    }
    
    static func clothDecommission(article: Int, number: Int, length: Double, complition: @escaping (Bool)->(Void)) {
        guard let url = URL(string: baseURL + "/cloth/\(article)/\(number)?length=\(length)") else {
            return
        }
        
        let request = createPatchRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            print(response.statusCode)
            if response.statusCode == 200 {
                print("Succes")
                complition(true)
            } else {
                complition(false)
            }
            
        }
        task.resume()
        
    }
    
    static func getAccessoryAmount(article: Int, complition: @escaping (accessoryAmountResponse)->(Void)) {
        guard let url = URL(string: baseURL + "/accessory/\(article)") else { return }
        
        let request = createGetRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let castedData = try NetworkManager.decoder.decode(accessoryAmountResponse.self, from: data)
                complition(castedData)
                print("DATA:")
                print(castedData)
            } catch(let e) {
                print("decode err: \(e)")
            }
            
        }
        task.resume()
    }

    
    static func getClothMapping(orderId: Int, complition: @escaping([MappingClothModel])->(Void)) {
        guard let url = URL(string: baseURL + "/get_cloth_mappings/\(orderId)") else { return }
        
        let request = createGetRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            print(response.statusCode)
            do {
                let castedData = try NetworkManager.decoder.decode([MappingClothModel].self, from: data)
                complition(castedData)
                print("DATA:")
                print(castedData)
            } catch(let e) {
                print("decode err: \(e)")
            }
            
        }
        task.resume()
        
    }
    
    static func getProductCountByOrder(orderId: Int, complition: @escaping([ProductsByOrderModel])->(Void)) {
        guard let url = URL(string: baseURL + "/get_products_by_order_id/\(orderId)") else { return }
        
        let request = createGetRequest(url: url, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            print(response.statusCode)
            do {
                let castedData = try NetworkManager.decoder.decode([ProductsByOrderModel].self, from: data)
                complition(castedData)
                print("DATA:")
                print(castedData)
            } catch(let e) {
                print("decode err: \(e)")
            }
            
        }
        task.resume()
        
    }
    
}
