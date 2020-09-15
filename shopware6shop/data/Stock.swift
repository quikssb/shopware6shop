//
//  Stocks.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 15.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Stock: Codable, Identifiable {
    
    enum LocationTypeKey: String {
        case warehouse = "warehouse"
        case binLocation = "bin_location"
    }

    var id:String
    var quantity:Int
    var locationTypeTechnicalName:String
    var warehouse:Warehouse?
    var binLocation:BinLocation?
    var specialStockLocationTechnicalName:String?
    
    var mainWarehouse:Warehouse? {

        switch locationTypeTechnicalName {
            
        case LocationTypeKey.warehouse.rawValue:
            if let warehouse = warehouse {
                if(warehouse.isDefault) {
                    return warehouse
                }
            }
            
        case LocationTypeKey.binLocation.rawValue:
            if let warehouse = warehouse {
                if(warehouse.isDefault) {
                    return warehouse
                }
            }
            
        default:
            return nil
        }
        
        return nil
    }
    
    var warehouseName:String {
        
        if let warehouse = mainWarehouse {
            return warehouse.name
        } else {
            return locationTypeTechnicalName
        }
    }
}
