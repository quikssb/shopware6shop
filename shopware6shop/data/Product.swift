//
//  Product.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 15.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Product:Codable {
    
    var extensions:Extension
    var media:[Media]
    
    var mainWarehouse:Warehouse? {
        
        return extensions.pickwareErpStocks.filter {
            $0.filteredWarehouse?.isDefault ?? false
        }.first?.filteredWarehouse
    }
    
    var mainWarehouseStockQuantity:Int {
         
        return extensions.pickwareErpStocks.reduce(into: 0) {
            quantitySum, stock in
            
            if let warehouse = stock.filteredWarehouse {
                if(warehouse.isDefault) {
                    quantitySum += stock.quantity
                }
            }
        }
    }
    
    var firstImageUrl:String? {
 
        return media.first {
            $0.imageUrl != nil
        }?.imageUrl
    }
}
