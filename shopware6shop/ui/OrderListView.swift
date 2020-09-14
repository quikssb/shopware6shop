//
//  ContentView.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import SwiftUI

struct OrderListView: View {
    
    var orders = Orders()
    
    var body: some View {
    
        
        //orders.append(Order.example)
        
        NavigationView {
            List {
                ForEach(self.orders.items) { item in
                    OrderRowView(item: item)
                }
            }
            //.listStyle(GroupedListStyle())
            .navigationBarTitle("Shopware 6 Orders")
        }.onAppear(perform: NetworkService.login)
    }
}

struct OderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
