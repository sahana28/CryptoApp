//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 13/08/24.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject private var viewModel = HomeViewModel()
    @State var showLaunchView : Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .toolbar(.hidden)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(viewModel)
                
                ZStack {
                    if showLaunchView  {
                        LaunchViiew(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
                
                
                
            }
            
            
        }
    }
}
