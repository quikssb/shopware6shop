//
//  ObservedOrders.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

class ObservedOrders:ObservableObject {
    
    @Published var orders = [Order]()
}
