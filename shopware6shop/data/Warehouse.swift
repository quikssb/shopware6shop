//
//  Warehouse.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 15.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Warehouse: Codable, Identifiable {
    
    var id:String
    var name:String
    var isDefault:Bool
}
