//
//  ContentView.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import SwiftUI

struct OrderListView: View {
    
    @EnvironmentObject var orders : ObservedOrders
    
    var body: some View {
    
        NavigationView {
            List {
                ForEach(self.orders.orders) { order in
                    OrderRowView(order: order)
                }
            }.navigationBarTitle("Shopware 6 Orders")
        }.onAppear(perform: loadOrders)
    }
    
    private func loadOrders() {
        
        NetworkService.getOrders(completion: {orderResponse in
            
            if let ordersFromServer = orderResponse.orders {
                self.orders.orders = ordersFromServer.data
            } else {
                //TODO: show little message, equivalent to Toast in Android
                print(orderResponse.printedError ?? "An error occured")
            }
        })
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
