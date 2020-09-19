//
//  LoginRequest.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let grant_type: String = "password"
    let client_id: String = "administration"
    let scopes: String = "write"
    var username: String
    var password: String
    var baseURL: String
    
    #if DEBUG
    static let testuser = LoginRequest(username: "demo", password: "demo", baseURL: "https://sw6demo.pickware.de")
    #endif
}
