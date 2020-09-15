//
//  OderListItemView.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

/*
{
    "associations": {
        "lineItems": {
            "associations": {
                "product": {
                    "associations": {
                        "pickwareErpStocks" : {
                            "associations": {
                                "binLocation" : {
                                    "associations":{
                                        "warehouse" : {
                                        }
                                    }
                                },
                                "warehouse" : {
                                }
                            }
                        }
                    }
                }
            }
        },
        "deliveries": {
            "associations": {
                "shippingMethod": {
                }
            }
        },
        "stateMachineState": {
        }
    },
    "includes": {
        "order": ["id", "orderNumber", "orderDateTime", "lineItems", "shippingTotal", "deliveries", "stateMachineState"],
        "order_line_item": ["id", "label", "productId", "quantity", "product"],
        "order_delivery": ["id", "shippingMethod"],
        "state_machine_state": ["id", "technicalName"],
        "shipping_method": ["id", "name"],
        "product": ["id", "extensions"]
    },
    "filter": [
        { "type": "equals", "field": "stateMachineState.technicalName", "value": "open" }
    ]
}
*/

import SwiftUI

struct OrderRowView: View {
    
    var order: Order
    
    var body: some View {
        
        NavigationLink(destination: OrderDetailView(order: order)) {
            HStack {
            
                //VStack places Views vertically
                VStack(alignment: .leading) {
                    Text("Order number: \(order.orderNumber)")
                    Text(order.orderDateTimeFormatted)
                    //Text(String("\(item.lineItemsCount)"))
                }
                
                //That will automatically take up all available free space, meaning that our picture will now be on the far left and the restrictions on the far right.
                Spacer()
                
                //tell the restriction string is the id itself
                //VStack places Views vertically
                VStack(alignment: .leading) {
                    Text(String("Items: \(order.lineItemsCount)"))
                    Text(String("Shipping: \(order.shippingMethod)"))
                }
            }
        }
    }
}

/*
 struct OrderRowView_Previews: PreviewProvider {
 static var previews: some View {
 OrderRowView(item: Order.example)
 }
 }
 */
