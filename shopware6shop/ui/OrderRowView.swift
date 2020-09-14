//
//  OderListItemView.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import SwiftUI

struct OrderRowView: View {
    
    var item: Order
    
    var body: some View {
        
        HStack {

            //VStack places Views vertically
            VStack(alignment: .leading) {
                Text(item.id.uuidString)
                Text(String("\(item.productCount)"))
            }
            
            //That will automatically take up all available free space, meaning that our picture will now be on the far left and the restrictions on the far right.
            Spacer()
            
            //tell the restriction string is the id itself
            //VStack places Views vertically
            VStack(alignment: .leading) {
                Text(item.date)
                Text(item.deliveryType)
            }
        }
    }
}

struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRowView(item: Order.example)
    }
}
