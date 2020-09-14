//
//  order.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Order: Codable, Equatable, Identifiable {
    var id: UUID
    var date: String
    var productCount: Int
    var deliveryType: String

    #if DEBUG
    static let example = Order(id: UUID(), date: "12.09.2020", productCount: 5, deliveryType: "Standard")
    #endif
}
