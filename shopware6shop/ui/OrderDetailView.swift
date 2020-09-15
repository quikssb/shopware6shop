//
//  OrderDetailView.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 15.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import SwiftUI

struct OrderDetailView: View {
    
    var order:Order
    
    var body: some View {
        
            VStack(alignment: .leading) {
                
                Text("Order date: \(order.orderDateTimeFormatted)")
                Text(String("Number of items: \(order.lineItemsCount)"))
                Text(String("Shipping: \(order.shippingMethod)"))

                List {
                    ForEach(self.order.lineItems) { item in
                        Text(item.label)
                        
                        
                    }
                }.navigationBarTitle("Items")

                
                //tell the restriction string is the id itself
                //VStack places Views vertically
                //HStack(alignment: .leading) {

                //}
            }.navigationBarTitle("Order number \(order.orderNumber)")
        }
    
}

/*
struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView()
    }
}
 */
