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

    static let loginURL = "https://next.pickware.de/api/oauth/token"
    static let getOrderURL = "https://next.pickware.de/api/v3/search/order"
    
    static var token:String = ""
    
    static func login(completion: @escaping ([Order]) -> Void) {
            
        AF.request(loginURL,
                       method: .post,
                       parameters: LoginRequest.testuser,
                       encoder: JSONParameterEncoder.default).responseDecodable(of:LoginResponse.self) { response in
                        
                if let value = response.value {
                    token = value.access_token
                    getOrders(completion: completion)
                }
            }
        
    }
    
    static func getOrders(completion: @escaping ([Order]) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        //todo: put names depending on classes
        let parameters: Parameters =
        [
                "associations":
                [
                    "lineItems" : [:],
                    "deliveries":
                        [
                            "associations":
                                [
                                    "shippingMethod" : [:]
                                ]
                        ],
                    "stateMachineState": [:]
                ],
                "includes":
                [
                        "order" : ["id", "orderNumber", "orderDateTime", "lineItems", "shippingTotal", "deliveries", "stateMachineState"],
                        "order_line_item" : ["id", "label", "productId", "quantity"],
                        "order_delivery" : ["id", "shippingMethod"],
                        "state_machine_state" : ["id", "technicalName"],
                        "shipping_method" : ["id", "name"]
                ],
                "filter":[
                    [
                        "type" : "equals",
                        "field": "stateMachineState.technicalName",
                        "value": "open"
                    ]
                ],
        ]
            //.responseDecodable(of:Orders.self)
            
            AF.request(getOrderURL,
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
                       .responseDecodable(of:Orders.self) { response in
                       //.responseJSON() { response in
                        
                    if let value = response.value {
                        print(response)
                        completion(value.data)
                    } else {
                        print(response.error)
                    }
            }
        
    }
}
