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
                        
                        //HStack {
                            //TODO: show picture later
                            //Spacer()
                            
                        VStack(alignment: .leading) {
                            Text("Name: \(item.label)")
                            Text("Article Number: \(item.productId)")
                            Text(String("Quantity: \(item.quantity)"))
                            Text(item.product.mainWarehouseAndQuantityDescription)
                        }
                    }
                }.navigationBarTitle("Items")
                
                HStack(alignment: .center) {
                    Button(action: {
                        NetworkService.shipOrder(orderDeliveryId: self.order.deliveries.first!.id, warehouseId: self.order.lineItems.first!.product.getMainWarehouseId())
                    }) {
                        Spacer()
                        Text("Send order")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title)
                        Spacer()
                    }
                }

                
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
