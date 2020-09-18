//
//  Media.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 18.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Foundation

struct Media:Codable, Identifiable {
    
    let mediaTypeImage = "IMAGE"
    
    var id:String
    var media:MediaDetail
    
    var imageUrl:String? {
        
        var imageUrl:String?
        
        if(media.mediaType.name == mediaTypeImage) {
            imageUrl = media.url;
        }
        
        return imageUrl
    }
}
