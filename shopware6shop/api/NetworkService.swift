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
    
    static func login() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            AF.request(loginURL,
                       method: .post,
                       parameters: LoginRequest.testuser,
                       encoder: JSONParameterEncoder.default).responseDecodable(of:LoginResponse.self) { response in
                        
                    if let value = response.value {
                        token = value.access_token
                        getOrders()
                    }
            }
        }
    }
    
    static func getOrders() {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        let parameters: Parameters = [
            "associations":
                [
                    "lineItems" : [],
                    "deliveries": [],
                    "stateMachineState": []
            ],
            "includes":
                [
                    "order" : ["id", "orderNumber", "orderDateTime", "lineItems", "shippingTotal", "deliveries", "stateMachineState"],
                    "order_line_item" : ["id", "label", "productId", "quantity"],
                    "order_delivery" : ["shippingMethod"],
                    "state_machine_state" : ["technicalName"]
            ],
            "filter":[
                [
                    "type" : "equals",
                    "field": "stateMachineState.technicalName",
                    "value": "open"
                ]
            ],
        ]
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            //.responseDecodable(of:Orders.self)
            
            AF.request(getOrderURL,
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseDecodable(of:Orders.self) { response in
                        
                    if let value = response.value {
                        print(response)
                    } else {
                        print(response.error)
                    }
            }
        }
    }
}
