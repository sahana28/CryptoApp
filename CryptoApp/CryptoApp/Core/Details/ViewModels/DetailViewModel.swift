//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 23/08/24.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject {
    
    @Published var overviewStatistics : [StatisticsModel] = []
    @Published var additionalStatistics : [StatisticsModel] = []
    @Published var coinDetailService: CoinDetailDataService
    @Published var coinDescription : String? = nil
    @Published var websiteURL : String? = nil
    @Published var redditURL : String? = nil

    @Published var coin: CoinModel
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.coin = coin
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink {[weak self] (returnedCoinModelArray) in
                self?.overviewStatistics = returnedCoinModelArray.overview
                self?.additionalStatistics = returnedCoinModelArray.additional
               
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink {[weak self] (returnedCoinDescription) in
                self?.coinDescription = returnedCoinDescription?.readableDescription
                self?.websiteURL = returnedCoinDescription?.links?.homepage?.first
                self?.redditURL = returnedCoinDescription?.links?.subredditURL
               
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailModel : CoinDetailModel?, coin: CoinModel ) -> (overview: [StatisticsModel], additional: [StatisticsModel]) {
        
        return (createOverviewArray(coin: coin),additionalDetailsArray(coin: coin, coinDetailModel: coinDetailModel))
    }
    
    
    private func createOverviewArray(coin: CoinModel) -> [StatisticsModel] {
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let pricePercentageChange = coin.priceChangePercentage24H
        let priceSet = StatisticsModel(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChange = coin.marketCapChangePercentage24H
        let marketSet = StatisticsModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
        
        let rank = "\(coin.rank)"
        let rankStat = StatisticsModel(title: "Market Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticsModel(title: "Volume", value: volume)
        
        let overviewArray : [StatisticsModel] = [priceSet, marketSet, rankStat, volumeStat]
        return overviewArray
    }
    
    private func additionalDetailsArray(coin: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatisticsModel] {
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticsModel(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticsModel(title: "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
        let priceStat = StatisticsModel(title: "24h Price Change", value: priceChange, percentageChange: coin.priceChangePercentage24H)
        
        let marketCapChange24h = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapChangePercentage24h = coin.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticsModel(title: "24h Market Cap Change", value: marketCapChange24h,percentageChange: marketCapChangePercentage24h)
        
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = (blockTime == 0) ? "" : "\(blockTime)"
        let blockStat = StatisticsModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticsModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray : [StatisticsModel] = [highStat, lowStat, priceStat, marketCapChangeStat, blockStat, hashingStat]
        return additionalArray
    }
}
