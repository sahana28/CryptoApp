//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 17/08/24.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    @Published var statistics : [StatisticsModel] = []
    @Published var allCoins : [CoinModel] = []
    @Published var marketData : MarketDataModel? = nil
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText : String = ""
    @Published var isLoading : Bool = false
    @Published var sortOption : SortOption = .holdings
    
    private let coinDataServices = CoinDataServices()
    private let marketDataServices = MarketDataServices()
    private let portfolioDataServices = PortfolioEntityServices()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        self.subscribeAllCoins()
    }
    
    private func subscribeAllCoins() {
//        dataService.$allCoins
//            .sink {[weak self] coins in
//                self?.allCoins = coins
//            }
//            .store(in: &cancellables)
        
        //updates coins
        $searchText
            .combineLatest(coinDataServices.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDataServices.$savedEntities)
            .map(mapAllCoinsToPortfolioEntities)
            .sink { [weak self] receivedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: receivedCoins)
            }
            .store(in: &cancellables)
        
        //updates market data
        marketDataServices.$marketData
            .combineLatest($portfolioCoins)
            .map (getStatisticsModel)
            .sink { [weak self ] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataServices.updatePortfolio(coin: coin, amount: amount)
        
    }
    
    func reloadCoinPrices() {
        isLoading = true
        coinDataServices.getCoins()
        marketDataServices.getMarketData()
        HapticManager.notification(type: .success)
        
    }
    
    private func filterCoin(searchText: String, coins: [CoinModel]) -> [CoinModel] {
        guard !searchText.isEmpty else {
            return coins
        }
        let lowercaseText = searchText.lowercased()
        let filteredCoins =  coins.filter { coins in
            return  coins.id.lowercased().contains(lowercaseText) ||
            coins.name.lowercased().contains(lowercaseText) ||
            coins.symbol.lowercased().contains(lowercaseText)
        }
        return filteredCoins
    }
    
    private func filterAndSortCoins(searchText: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoin(searchText: searchText, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel])  {
        switch sort {
        case .rank, .holdings :
            coins.sort { ($0.rank < $1.rank)}
        case .rankReversed, .holdingsReversed:
            coins.sort { ($0.rank > $1.rank)}
        case .price:
            coins.sort { ($0.currentPrice > $1.currentPrice)}
        case .priceReversed:
            coins.sort { ($0.currentPrice < $1.currentPrice)}
        }
        
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        //will only sort by holding or reverse holdings
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingValue > $1.currentHoldingValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingValue < $1.currentHoldingValue})
        default:
            return coins
        }
    }
    
    private func mapAllCoinsToPortfolioEntities(coin: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        coin
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where:{ $0.coinID == coin.id}) else { return nil }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func getStatisticsModel(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticsModel]  {
        var stats : [StatisticsModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = StatisticsModel(title: "24h Volume", value: data.volume)
        let bitcoinDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioSumValue = portfolioCoins.map({$0.currentHoldingValue})
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { coins -> Double in
                let currentValue = coins.currentPrice
                let percentageChange = (coins.priceChangePercentage24H ?? 0)/100
                let previousValue = currentValue / (1 + percentageChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioSumValue - previousValue) / previousValue)
        
        let portfolioValue = StatisticsModel(title: "Portfolio Value", value: portfolioSumValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
        marketCap,
        volume,
        bitcoinDominance,
        portfolioValue
        ])
        return stats
    }
 }
