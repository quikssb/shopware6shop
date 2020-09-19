//
//  MotherView.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 19.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import SwiftUI

struct MotherView : View {
    
    public static let loginViewKey = "loginViewKey"
    public static let listViewKey = "listViewKey"
    
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        
            VStack {
                if viewRouter.currentPage == MotherView.loginViewKey {
                    LoginView(viewRouter: viewRouter)
                } else if viewRouter.currentPage == MotherView.listViewKey {
                    OrderListView(viewRouter: viewRouter)
                }
            }
    }
}
