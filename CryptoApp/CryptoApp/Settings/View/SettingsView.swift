//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 30/08/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    let defaultURL = URL(string:"https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/swiftfulthinking")!
    let coinGeckoURL = URL(string: "https://coingecko.com")!
    
    
    var body: some View {
        NavigationView {
            ZStack {
                //background layer
                Color.theme.background
                    .ignoresSafeArea()
                
                //content layer
                
                List {
                    appSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
        
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    })
                }
            }
        }
        
        
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var appSection : some View {
        Section(header: Text("Swiftful Thinking"), content: {
            VStack(alignment: .leading, content: {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by folllowing @Swiftful Thinking course on Youtube. It uses MVVM, Combine and CoreData")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            })
            .padding()
            Link("Subscribe on Youtube", destination: youtubeURL)
                .accentColor(.blue)
            
        })
    }
    
    private var coinGeckoSection : some View {
        Section(header: Text("CoinGecko"), content: {
            VStack(alignment: .leading, content: {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The crypto currency data used in the app comes from Coingecko API")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            })
            .padding()
            Link("Visit CoinGecko", destination: coinGeckoURL)
                .accentColor(.blue)
            
        })
    }
}
