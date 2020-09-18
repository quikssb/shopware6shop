//
//  MediaDetail.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 18.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct MediaDetail: Codable, Identifiable {
    
    var id:String
    var url:String
    var mediaType:MediaType
}
