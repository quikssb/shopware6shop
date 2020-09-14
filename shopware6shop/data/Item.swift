//
//  Item.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Item:Decodable, Identifiable {
    
    var id: String
    var productId: String
    var quantity: Int
    var label: String
}
