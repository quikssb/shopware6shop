//
//  Stocks.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 15.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Stock: Codable, Identifiable {

    var id:String
    var quantity:Int
    var warehouse:Warehouse?
    var binLocation:BinLocation?
    
    var filteredWarehouse:Warehouse? {
        
        if let warehouse = warehouse {
            return warehouse
        } else if let warehouse = binLocation?.warehouse {
            return warehouse
        } else {
            return nil
        }
    }
}
