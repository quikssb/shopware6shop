//
//  ViewRouter.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 19.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//


import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = MotherView.loginViewKey {
        didSet {
            objectWillChange.send(self)
        }
    }
}
