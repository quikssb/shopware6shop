//
//  LoginVIew.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 19.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    @State private var loginDisabled = false
    @State private var loading = false
    @State private var buttonText = "LOGIN"
    
    @State private var url: String = "https://sw6demo.pickware.de"
    @State private var username: String = String()
    @State private var password: String = String()
    
    var body: some View {
        
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()

            TextField("Shop-URL", text: $url)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            
            TextField("Username", text: $username)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            
            ActivityIndicator($loading)
                .padding()
            
            Button(action: {
                self.loading = true
                self.loginDisabled = true
                self.login()
            }) {
                Text(buttonText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .disabled(loginDisabled)
            .padding(30)
        }
        .padding()
    }
    
    private func login() {
        
        NetworkService.login(username: username, password: password, url: url) {
            (success, error) in
            
            self.loading = false
            self.loginDisabled = false
            
            if(success) {
                //With this command the OrderListView gets opened
                self.viewRouter.currentPage = MotherView.listViewKey
            } else {
                
                if let error = error {
                    print(error.localizedDescription)
                }
                self.buttonText = "ERROR"
            }
        }
    }
}
