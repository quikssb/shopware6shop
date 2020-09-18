//
//  OrderDetailView.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 15.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderDetailView: View {
    
    var order:Order
    
    @State private var buttonDisabled = false
    @State private var buttonText = "Send order"
    
    var body: some View {
        
            VStack(alignment: .leading) {
                
                Text("Order date: \(order.orderDateTimeFormatted)")
                Text(String("Number of items: \(order.lineItemsCount)"))
                Text(String("Shipping: \(order.shippingMethod)"))

                List {
                    ForEach(self.order.lineItems) { item in
                        
                        WebImage(url: URL(string: item.product.media.first!.media.url))
                            .resizable()
                            .scaledToFit()
                            
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
                        self.shipOrder()
                    }) {
                        Spacer()
                        Text(buttonText)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title)
                        Spacer()
                    }.disabled(buttonDisabled)
                }

                
            }.navigationBarTitle("Order number \(order.orderNumber)")
        }
    
    private func shipOrder() {
        
        NetworkService.shipOrder(
            orderDeliveryId: self.order.deliveries.first!.id,
            warehouseId: self.order.lineItems.first!.product.getMainWarehouseId(),
            completion:  {success, error in
                
                if(success) {
                    self.buttonDisabled = true
                    self.buttonText = "Shipped"
                } else {
                    self.buttonText = "Error"
                }
        })
    }
}
