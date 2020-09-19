//
//  NetworkConstants.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 15.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkConstants {
    
    static let loginURL = { (baseURL: String) -> String in
        return "\(baseURL)/api/oauth/token"
    }
    
    static let orderURL = { (baseURL: String) -> String in
        return "\(baseURL)/api/v3/search/order"
    }
    
    static let pickwareErpShipOrderURL = { (baseURL: String) -> String in
        return "\(baseURL)/api/v2/_action/pickware-erp/ship-order-delivery-completely"
    }
        
    static var shipOrderURL = { (baseURL: String, deliveryId: String) -> String in
        return "\(baseURL)/api/v2/_action/order_delivery/\(deliveryId)/state/ship"
    }
    
    static var processOrderURL = { (baseURL: String, orderId: String) -> String in
        return "\(baseURL)/api/v2/_action/order/\(orderId)/state/process"
    }
    
    static var completeOrderURL = { (baseURL: String, orderId: String) -> String in
        return "\(baseURL)/api/v2/_action/order/\(orderId)/state/complete"
    }
    
    static var headers = { (token: String) -> HTTPHeaders in
        return [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json",
        ]
    }
    
    static var pickwareErpShipOrderParameters = { (orderDeliveryId: String, warehouseId: String) -> Parameters in
        return [
            "orderDeliveryId": "\(orderDeliveryId)",
            "warehouseId": "\(warehouseId)",
        ]
    }
    
    static let shipOrderParameters:Parameters = ["documentIds": [:]]
    
    //TODO: put properties of Order Class directly into parameter
    //How does this work?
    static let getOrderQuery: Parameters =
    [
        "associations":
        [
            "lineItems" :
            [
                "associations":
                [
                    "product" :
                    [
                        "associations":
                        [
                            "pickwareErpStocks":
                            [
                                "filter":
                                [[
                                    "type":"multi",
                                    "queries":
                                        [
                                            [
                                                "type":"equals",
                                                "field":"locationType.technicalName",
                                                "value":"warehouse"
                                            ],
                                            [
                                                "type":"equals",
                                                "field":"locationType.technicalName",
                                                "value":"bin_location"
                                            ],
                                        ],
                                    "operator":"OR"
                                ]],
                                "associations":
                                [
                                    "warehouse" : [:],
                                    "binLocation" :
                                    [
                                        "associations":
                                        [
                                            "warehouse" : [:]
                                        ]
                                    ]
                                ]
                            ],
                            "media" : [:]
                        ]
                    ]
                ]
            ],
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
            "order_line_item" : ["id", "label", "productId", "quantity", "product"],
            "order_delivery" : ["id", "shippingMethod"],
            "state_machine_state" : ["id", "technicalName"],
            "shipping_method" : ["id", "name"],
            "product": ["id", "extensions", "media"]
        ],
        "filter":
        [
            [
                "type" : "equals",
                "field": "stateMachineState.technicalName",
                "value": "open"
            ]
        ],
        "sort":
        [
            [
                "order" : "ASC",
                "field": "orderNumber"
            ]
        ],
    ]
}
