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
    var locationTypeTechnicalName:String
    var warehouse:Warehouse?
    var binLocation:BinLocation?
    
    //TODO: make property which gets name with logic
}
