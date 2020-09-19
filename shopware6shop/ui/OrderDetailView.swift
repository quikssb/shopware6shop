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
    
    @State private var loading = false
    @State private var buttonDisabled = false
    @State private var buttonText = "Send order"
    
    var body: some View {
        
        VStack(alignment: .center) {
                
            Text("Order date: \(order.orderDateTimeFormatted)")
            Text(String("Number of items: \(order.lineItemsCount)"))
            Text(String("Shipping: \(order.shippingMethod)"))
            
            VStack(alignment: .leading) {
                
                Text("Items")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                
                List {
                    ForEach(self.order.lineItems) { item in
                        
                        VStack(alignment: .center) {
                            Text("\(item.label)")
                                .font(.title)
                                .padding()
                            
                            Text("Article Number:")
                            Text("\(item.productId)")
                            Text(String("Quantity: \(item.quantity)"))
                            Text("Stock: \(item.product.mainWarehouseAndQuantityDescription)")
                            
                            //Note: SwiftUI doesn't like optional unwrapping..
                            if(item.product.firstImageUrl != nil) {
                                
                                WebImage(url: URL(string: item.product.firstImageUrl!))
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                            }
                        }
                    }
                }
            }
            
            ActivityIndicator($loading)
            
            HStack(alignment: .center) {

                Button(action: {
                    self.buttonDisabled = true
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
        
        self.loading = true
        
        NetworkService.shipAndCompleteOrder(
            orderDeliveryId: self.order.deliveries.first!.id,
            warehouseId: self.order.lineItems.first!.product.getMainWarehouseId(),
            orderId: self.order.id,
            completion:  {success, error in
                
                if(success) {
                    self.buttonText = "Shipped"
                    self.loading = false
                } else {
                    self.buttonText = "Error"
                    print(error.debugDescription)
                }
        })
    }
}
