//
//  State.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Delivery:Codable, Identifiable {
    
    var id: String
    var shippingMethod:ShippingMethod
}
