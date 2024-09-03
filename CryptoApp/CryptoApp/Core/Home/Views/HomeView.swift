//
//  HomeView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 13/08/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel : HomeViewModel
    @State private var showPortfolio : Bool = false // animate right
    @State private var showPortfolioView : Bool = false // show Portfolio View to add coins
    @State private var showSettingsView : Bool = false
    @State private var selectedCoin : CoinModel? = nil
    @State private var showDetailView : Bool = false
    
    var body: some View {
        ZStack {
            //Background Layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(viewModel)
                })
            
            VStack {
                headerView
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                columnTitles
                if !showPortfolio {
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                else {
                    ZStack(alignment: .top) {
                        if viewModel.portfolioCoins.isEmpty && viewModel.searchText.isEmpty {
                             emptyPortfolioCoinMessage
                        }
                        else {
                            portfolioCoinList
                        }
                    }
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: {
                    EmptyView()
                })
        )
        
    }
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(DeveloperInstance.instance.viewModel)
    
}

extension HomeView {
    
    private var headerView : some View {
        HStack {
            
            // withAnimation(.none) {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(content: {
                    CircleButtonAnimationView(animate: $showPortfolio)
                })
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                    else {
                        showSettingsView.toggle()
                    }
                }
                .animation(.none)
            
            // }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                    
                }
            
            
        }
        .padding()
    }
    
    private var allCoinList : some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showPortfolio)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            .listRowBackground(Color.theme.background)
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinList : some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showPortfolio)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            .listRowBackground(Color.theme.background)
        }
        .listStyle(.plain)
    }
    
    private var emptyPortfolioCoinMessage : some View {
        Text("You haven't added any coins to your portfolio yet. Click '+' to get started.")
           .font(.callout)
           .foregroundStyle(Color.theme.accent)
           .fontWeight(.medium)
           .multilineTextAlignment(.center)
           .padding(50)
    }
    
    private var columnTitles : some View {
        HStack {
            HStack(spacing: 4.0) {
                Text("Coin")
                    .padding(.leading, 20)
                Image(systemName: "chevron.down")
                    .opacity(viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
            }
            
            Spacer()
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                    
                }
            }
                
            HStack(spacing: 1.0) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(viewModel.sortOption == .price || viewModel.sortOption == .priceReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
                
            }
            
            
            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    viewModel.reloadCoinPrices()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)
            

        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding()
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
}
