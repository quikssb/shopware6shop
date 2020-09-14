//
//  order.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Order: Codable, Identifiable {
    var id: String
   // var attributes: Attributes
    //var productCount: Int
    //var deliveryType: String

    #if DEBUG
    static let example = Order(id: "123")
    //static let example = Order(id: "123", attributes: Attributes(orderNumber: "100", orderDateTime: "12.09.2020"))
    //static let example = Order(id: "123", attributes: Attributes(orderNumber: 100, orderDateTime: "12.09.2020"), productCount: 5, deliveryType: "Standard")
    #endif
}
