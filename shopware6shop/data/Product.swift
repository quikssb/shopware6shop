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
    
    //TODO: optimize logic of computing mainWarehouse and its functions
    
    var mainWarehouseAndQuantityDescription:String {
                
        var name:String = String()
        
        extensions.pickwareErpStocks.forEach() { stock in
            
            if let mainWarehouseTmp = stock.mainWarehouse{
                name = mainWarehouseTmp.name
            }
        }
        
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
        
        var id:String = ""
        
        extensions.pickwareErpStocks.forEach() { stock in
            
            if let mainWarehouseTmp = stock.mainWarehouse{
                id =  mainWarehouseTmp.id
                //TODO: understand how break works
            }
        }
        
        return id
    }
    
    func getStockQuantityMainWarehouse(name: String) -> Int {
        
        var quantity = 0
        
        extensions.pickwareErpStocks.forEach() { stock in
            
            if(name == stock.warehouseName) {
                quantity = quantity + stock.quantity
            }
        }
        
        return quantity
    }
}
