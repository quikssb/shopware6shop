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
    
    var stockQuantity:Int {
        
        var quantity = 0
        
        extensions.pickwareErpStocks.forEach() { stock in
            quantity = quantity + stock.quantity
        }
        
        return quantity
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
}
