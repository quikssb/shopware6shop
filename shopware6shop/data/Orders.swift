//
//  Orders.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

//todo: geht auch struct?
class Orders:ObservableObject, Codable {
    
    var data = [Order]()
}
