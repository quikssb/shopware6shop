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
    @State private var buttonText = "SEND ORDER"
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Text("Order date: \(OrderListView.dateTimeFormatted(order.orderDateTime))")
            Text(String("Number of items: \(order.lineItemsCount)"))
            Text(String("Shipping: \(order.shippingMethod)"))
            
            VStack(alignment: .center) {
                
                List {
                    Section(header:
                        Text("Items")
                            .frame(maxWidth: .infinity, alignment: .center)
                    ) {
                        ForEach(self.order.lineItems) { item in
                            
                            VStack(alignment: .center) {
                                
                                Text("\(item.label)")
                                    .font(.title)
                                    .padding()
                                
                                Text("Article Number:")
                                Text("\(item.productId)")
                                Text(String("Ordered quantity: \(item.quantity)"))
                                Text("\(item.product.mainWarehouse?.name ?? "No main warehouse"), Quantity: \(item.product.mainWarehouseStockQuantity)")
                                
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
            }
            
            ZStack {
                Button(action: {
                    self.buttonDisabled = true
                    self.shipOrder()
                }) {
                    Spacer()
                    Text(buttonText)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                    Spacer()
                }
                .disabled(buttonDisabled)
                .padding(.bottom, 10)
                
                ActivityIndicator($loading)
            }
        }.navigationBarTitle("Order number \(order.orderNumber)")
    }
    
    private func shipOrder() {
        
        self.loading = true
        
        guard let orderDeliveryId = self.order.deliveries.first?.id else {
            print("orderDeliveryId not found")
            return
        }
        
        guard let warehouseId = self.order.lineItems.first?.product.mainWarehouse?.id else {
            print("WarehouseId not found")
            return
        }
        
        NetworkService.shipAndCompleteOrder(
            orderDeliveryId: orderDeliveryId,
            warehouseId: warehouseId,
            orderId: self.order.id,
            completion:  {success, error in
                
                if(success) {
                    self.buttonText = "SHIPPED"
                    self.loading = false
                } else {
                    self.buttonText = "ERROR"
                    print(error.debugDescription)
                }
        })
    }
}
