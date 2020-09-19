//
//  NetworkManager.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

struct NetworkService {
    
    private static var token:String = String()
    private static var loginRequestData:LoginRequest = LoginRequest.testuser
    
    static func login(username:String, password:String, url:String,
                      completion: @escaping (Bool, Error?) -> Void) {
        
        loginRequestData = LoginRequest(username: username, password: password, baseURL: url)
        
        loginRequest(loginRequest: loginRequestData)
        .done {
            completion(true, nil)
        }.catch { error in
            completion(false, error)
        }
    }
    
    static func getOrders(completion: @escaping (Orders?, Error?) -> Void) {
        
        getOrdersRequest()
        .done { orders in
            completion(orders, nil)
        }.catch { error in
            if let httpCode = error.asAFError?.responseCode {
                if(httpCode == 401) {
                
                    loginRequest(loginRequest: loginRequestData)
                    .done {
                        getOrders(completion: completion)
                    }.catch { error in
                        completion(nil, error)
                    }
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    static func shipAndCompleteOrder(orderDeliveryId: String, warehouseId: String, orderId: String,
                                     completion: @escaping (Bool, Error?) -> Void) {
        
        let baseURL = loginRequestData.baseURL
        
        shipAndCompleteOrderRequest(
            url: NetworkConstants.pickwareErpShipOrderURL(baseURL),
            parameters: NetworkConstants.pickwareErpShipOrderParameters(orderDeliveryId, warehouseId))
        .then {
            shipAndCompleteOrderRequest(
                url: NetworkConstants.shipOrderURL(baseURL, orderDeliveryId),
                parameters: NetworkConstants.shipOrderParameters
            )
        }.then {
            shipAndCompleteOrderRequest(
                url: NetworkConstants.processOrderURL(baseURL, orderId),
                parameters: NetworkConstants.shipOrderParameters
            )
        }.then {
            shipAndCompleteOrderRequest(
                url: NetworkConstants.completeOrderURL(baseURL, orderId),
                parameters: NetworkConstants.shipOrderParameters
            )
        }.done {
            completion(true, nil)
        }.catch { error in
            if let httpCode = error.asAFError?.responseCode {
                if(httpCode == 401) {
                
                    loginRequest(loginRequest: loginRequestData)
                    .done {
                        shipAndCompleteOrder(orderDeliveryId: orderDeliveryId, warehouseId: warehouseId, orderId: orderId,completion: completion)
                    }.catch { error in
                        completion(false, error)
                    }
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    private static func loginRequest(loginRequest:LoginRequest) -> Promise<Void> {
        
        return Promise { promise in
            
            AF.request(NetworkConstants.loginURL(loginRequestData.baseURL),
                       method: .post,
                       parameters: loginRequest,
                       encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of:LoginResponse.self) { response in
                        
                switch response.result {
                    
                case .success(let loginResponse):
                    token = loginResponse.access_token
                    promise.fulfill(())
                    
                case .failure(let error):
                    promise.reject(error)
                }
            }
        }
    }
    
    private static func getOrdersRequest() -> Promise<Orders> {
        
        return Promise { promise in
            
            AF.request(NetworkConstants.orderURL(loginRequestData.baseURL),
                       method: .post,
                       parameters: NetworkConstants.getOrderQuery,
                       encoding: JSONEncoding.default,
                       headers: NetworkConstants.headers(token))
            .validate()
            .responseDecodable(of:Orders.self) { response in
                    
                switch response.result {
                    
                case .success(let orders):
                    promise.fulfill(orders)
                    
                case .failure(let error):
                    promise.reject(error)
                }
            }
        }
    }
    
    private static func shipAndCompleteOrderRequest(url:String, parameters:Parameters) -> Promise<Void> {
        
        return Promise { promise in

            AF.request(url,
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: NetworkConstants.headers(token))
            .validate()
            .response { response in
                    
                switch response.result {
                    
                case .success(_):
                    promise.fulfill(())
                    
                case .failure(let error):
                    promise.reject(error)
                }
            }
        }
    }
}
