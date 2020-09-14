//
//  NetworkManager.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Alamofire
import Foundation

struct NetworkService {
    
    static private var token:String = String()
    
    static func login(completion: @escaping ([Order]) -> Void) {
        
        AF.request(NetworkConstants.loginURL,
                   method: .post,
                   parameters: LoginRequest.testuser,
                   encoder: JSONParameterEncoder.default).responseDecodable(of:LoginResponse.self) { response in
                    
                    if let value = response.value {
                        token = value.access_token
                        getOrders(completion: completion)
                    } else {
                        //(with error)
                        completion([Order]())
                    }
        }
        
    }
    
    static func getOrders(completion: @escaping ([Order]) -> Void) {
        
        let headers: HTTPHeaders =
        [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json",
        ]
        
        AF.request(NetworkConstants.orderURL,
                   method: .post,
                   parameters: NetworkConstants.orderQuery,
                   encoding: JSONEncoding.default,
                   headers: NetworkConstants.headers(token))
                .responseDecodable(of:Orders.self) { response in
                //.responseJSON() { response in
                
                //if let value = response.value {
                if let statusCode = response.response?.statusCode {
                    
                    print(response)
                    print(statusCode)
                    
                    if(statusCode == 200) {
                        
                        if let value = response.value {
                            completion(value.data)
                        }
                        
                    } else if (statusCode == 401) {
                        
                        login(completion: completion)
                    } else {
                        
                        //(with error)
                        completion([Order]())
                    }
                }
                else {
                    //(with error)
                    completion([Order]())
                }
        }
    }
}
