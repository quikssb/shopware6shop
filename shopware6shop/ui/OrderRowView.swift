//
//  OderListItemView.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import SwiftUI

struct OrderRowView: View {
    
    var order: Order
    
    var body: some View {
        
        NavigationLink(destination: OrderDetailView(order: order)) {
            HStack {
            
                VStack(alignment: .leading) {
                    Text("Order number: \(order.orderNumber)")
                    Text(OrderListView.dateTimeFormatted(order.orderDateTime))
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(String("Items: \(order.lineItemsCount)"))
                    Text(String("Shipping: \(order.shippingMethod)"))
                }
            }
        }
    }
}
