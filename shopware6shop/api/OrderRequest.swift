//
//  OrderRequest.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 18.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct OrderRequest:Codable {
    var documentIds:[String]
    
    static let orderRequestEmpty = OrderRequest(documentIds: [String]())
}
