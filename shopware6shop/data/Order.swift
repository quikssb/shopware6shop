//
//  order.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

class Order: Codable, Identifiable {
    
    //TODO: uuid?
    var id: String
    var orderNumber: String
    var orderDateTime: String
    var lineItems: [Item]
    var deliveries: [Delivery]
    
    var lineItemsCount: Int {
        
        return lineItems.count
    }
    
    var shippingMethod: String {
        
        if let delivery = deliveries.first {
            return delivery.shippingMethod.name
        } else {
            return ""
        }
    }
}
