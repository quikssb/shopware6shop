//
//  ContentView.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import SwiftUI

struct OrderListView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var orders : ObservedOrders
    
    var body: some View {
    
        NavigationView {
            List {
                ForEach(self.orders.orders) { order in
                    OrderRowView(order: order)
                }
            }
            .navigationBarTitle("Shopware 6 Orders")
            .onAppear(perform: loadOrders)
        }
    }
    
    private func loadOrders() {
        
        NetworkService.getOrders(completion: {orders, error in
            
            if let ordersFromServer = orders {
                self.orders.orders = ordersFromServer.data
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
    }
}
