//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 21/08/24.
//

import SwiftUI


struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel : HomeViewModel
    @State private var selectedCoin : CoinModel? = nil
    @State private var coinQuantity : String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                    
                }
                
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    })
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    navBarTrailingButton
                }
            })
            .onChange(of: viewModel.searchText) {
                if viewModel.searchText == "" {
                    removeSelectedCoin()
                }
            }
        }
        
        
        
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperInstance.instance.viewModel)
}

extension PortfolioView {
    
    private var coinLogoList : some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach((viewModel.searchText.isEmpty && !viewModel.portfolioCoins.isEmpty) ? viewModel.portfolioCoins : viewModel.allCoins) { coins in
                    CoinLogoView(coin: coins)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coins)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coins.id ?   Color.theme.green : Color.clear , lineWidth: 1.0)
                        )
                }
                .frame(height: 120)
                .padding(.leading)
            }
        }
    }
    private var portfolioInputSection : some View {
        withAnimation(.none, {
            VStack {
                HStack {
                    Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "") is:")
                Spacer()
                    Text("\(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")")
                }
                
                Divider()
                HStack {
                    Text("Amount holding:")
                    Spacer()
                    TextField("Ex 1..4", text: $coinQuantity)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                Divider()
                HStack {
                    Text("Current Value")
                    Spacer()
                    Text(getCurrentValueOfPortfolioCoins().asCurrencyWith2Decimals())
                }
            }
            .padding()
            .font(.headline)
        })
    }
    
    private var navBarTrailingButton : some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("SAVE")
            })
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(coinQuantity) ? 1.0 : 0.0)
            )
        }
        .font(.headline)
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = viewModel.portfolioCoins.first(where: {$0.id == coin.id}), let amount = portfolioCoin.currentHoldings {
            coinQuantity = "\(amount)"
        }
        else {
            coinQuantity = ""
        }
        
    }
    
    private func getCurrentValueOfPortfolioCoins() -> Double {
        if let quantity = Double(coinQuantity) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0.0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin, let amount = Double(coinQuantity) else { return }
        viewModel.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        //hide keyboard
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
            
        })
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
    
    
}

