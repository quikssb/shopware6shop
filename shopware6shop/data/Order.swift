//
//  order.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

class Order: Codable, Identifiable {
    
    //TODO: UUID for id does not work?
    //The problem is the ID from the backend doesnt provide the fitting format
    //It has 32 chars, but needs 36 chars - 4 hyphen are missing
    //Solution would be to implement an extension of UUID, where the hyphen
    //get inserted manually. After that the JSONDecoder needs to be told
    //to use that extension.
    
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
