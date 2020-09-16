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
    
    static func login(completion: @escaping (OrderResponse) -> Void) {
        
        AF.request(NetworkConstants.loginURL,
                   method: .post,
                   parameters: LoginRequest.testuser,
                   encoder: JSONParameterEncoder.default).responseDecodable(of:LoginResponse.self) { response in
                    
                    if let value = response.value {
                        token = value.access_token
                        getOrders(completion: completion)
                    } else {
                        completion(OrderResponse(orders: nil, error: response.error, statusCode: response.response?.statusCode))
                    }
        }
        
    }
    
    static func getOrders(completion: @escaping (OrderResponse) -> Void) {
        
        //TODO: promises
        
        AF.request(NetworkConstants.orderURL,
                   method: .post,
                   parameters: NetworkConstants.getOrderQuery,
                   encoding: JSONEncoding.default,
                   headers: NetworkConstants.headers(token))
                .responseDecodable(of:Orders.self) { response in
                //.responseJSON() { response in
                
                if let statusCode = response.response?.statusCode {
                    
                    //print(response)
                    //print(statusCode)
                    
                    if(statusCode == 200) {
                        
                        if let value = response.value {
                            completion(OrderResponse(orders: value, error: nil, statusCode: response.response?.statusCode))
                        }
                    } else if (statusCode == 401) {
                        login(completion: completion)
                    } else {
                        completion(OrderResponse(orders: nil, error: response.error, statusCode: response.response?.statusCode))
                    }
                }
                else {
                    completion(OrderResponse(orders: nil, error: response.error, statusCode: response.response?.statusCode))
                }
        }
    }

    static func shipOrder(orderDeliveryId: String, warehouseId: String, completion: @escaping (Bool, String) -> Void) {
        
        AF.request(NetworkConstants.shipOrderURL,
                   method: .post,
                   parameters: NetworkConstants.shipOrderParameters(orderDeliveryId, warehouseId),
                   encoding: JSONEncoding.default,
                   headers: NetworkConstants.headers(token))
                  .responseJSON() { response in
                
                if let statusCode = response.response?.statusCode {
                    
                    //print(response)
                    //print(statusCode)
                    
                    if(statusCode == 200) {
                        
                        completion(true, String())
                        
                    } else if (statusCode == 401) {
                        //print(response.value)
                        completion(false, response.error?.errorDescription ?? "an error occured")
                        //TODO: change login behaviour with login screen
                        //login(completion: completion)
                    } else {
                        
                        completion(false, response.error?.errorDescription ?? "an error occured")
                    }
                }
                else {
                    //print(response.value)
                    //print(response.error)

                    completion(false, response.error?.errorDescription ?? "an error occured")
                }
        }
    }
}
