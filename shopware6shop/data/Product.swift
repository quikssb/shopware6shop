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
    
    //TODO: optimize logic of computing mainWarehouse and its functions
    
    var mainWarehouseAndQuantityDescription:String {
                
        var name:String = String()
        
        extensions.pickwareErpStocks.forEach() { stock in
            
            if let mainWarehouseTmp = stock.mainWarehouse{
                name = mainWarehouseTmp.name
            }
        }
        //TODO: ui logic into views
        return "\(name), Quantity: \(getStockQuantityMainWarehouse(name: name))"
    }
    
    var stockDescription:String {
        
        var description:String = String()
        var index = 0
        
        extensions.pickwareErpStocks.forEach() { stock in
            description += "Stock \(index) : \(stock.warehouseName), Quantity: \(stock.quantity)" + "\n"
            index += 1
        }
        
        return description
    }
    
    func getMainWarehouseId() -> String {
        
        extensions.pickwareErpStocks.compactMap({
            $0.mainWarehouse
        }).first?.id ?? ""
    }
    
    func getStockQuantityMainWarehouse(name: String) -> Int {
        
        var quantity = 0
        
        extensions.pickwareErpStocks.forEach() { stock in
            
            if(name == stock.warehouseName) {
                quantity += stock.quantity
            }
        }
        
        return quantity
    }
}
