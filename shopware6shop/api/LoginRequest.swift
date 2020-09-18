//
//  LoginRequest.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    var grant_type: String
    var client_id: String
    var scopes: String
    var username: String
    var password: String
    
    #if DEBUG
    static let testuser = LoginRequest(grant_type: "password", client_id: "administration", scopes: "write", username: "demo", password: "demo")
    #endif
}
