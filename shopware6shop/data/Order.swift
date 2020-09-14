//
//  order.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Order: Codable, Identifiable {
    
    //todo: geht auch uuid?
    var id: String
    var orderNumber: String
    var orderDateTime: String
    var lineItems: [Item]
    var deliveries: [Delivery]
    
    var lineItemsCount: Int {
        return lineItems.count
    }
    
    var shippingMethod: String {
        //return deliveries[0].shippingMethod
        return "a"
    }
    //

    #if DEBUG
    //static let example = Order(id: "123")
    //static let example = Order(id: "123", attributes: Attribute(orderNumber: "100", orderDateTime: "12.09.2020"))
    //static let example = Order(id: "123", attributes: Attributes(orderNumber: 100, orderDateTime: "12.09.2020"), productCount: 5, deliveryType: "Standard")
    #endif
}
