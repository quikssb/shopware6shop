//
//  order.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation
import SwiftDate

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
    
    var orderDateTimeFormatted: String {
        
        //TODO: convert time into German timezone (if not already happened)
        let dateFormat = "dd.MM.yyyy HH:mm"

        if let formattedDate = orderDateTime.toDate() {
            return "\(formattedDate.toFormat(dateFormat))"
        } else {
            return ""
        }
    }

    /*
    #if DEBUG
    //static let example = Order(id: "123")
    //static let example = Order(id: "123", attributes: Attribute(orderNumber: "100", orderDateTime: "12.09.2020"))
    //static let example = Order(id: "123", attributes: Attributes(orderNumber: 100, orderDateTime: "12.09.2020"), productCount: 5, deliveryType: "Standard")
    #endif
    */
}
