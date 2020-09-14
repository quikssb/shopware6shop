//
//  OrderResponse.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 15.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation
import Alamofire

struct OrderResponse {
    
    var orders: Orders?
    var error: AFError?
    var statusCode:Int?
    
    var printedError: String? {
        
        if let statusCode = statusCode, let error = error {
            return "StatusCode: \(statusCode)/nFollowing error: \(error)"
        } else {
            return nil
        }
    }
}
