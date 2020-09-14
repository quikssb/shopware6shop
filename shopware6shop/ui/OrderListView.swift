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
    
        
        //orders.append(Order.example)
        
        NavigationView {
            List {
                ForEach(self.orders.orders) { item in
                    OrderRowView(item: item)
                }
            }
            //.listStyle(GroupedListStyle())
            .navigationBarTitle("Shopware 6 Orders")
        }.onAppear(perform: loadOrders)
    }
    
    private func loadOrders() {
        
        NetworkService.login(completion: {orders in
            
            self.orders.orders = orders
        })
    }
}

struct OderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
