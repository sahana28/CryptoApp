//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 23/08/24.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails : CoinDetailModel? = nil
    var coinDetailSubscription : AnyCancellable?
    let coin : CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() -> Void {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {  return }
        
        coinDetailSubscription  = NetworkManager.download(from: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder.snakeCaseConverting)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self]  coinDetails in
                self?.coinDetails = coinDetails
                self?.coinDetailSubscription?.cancel()
            })
        
        
    }
}
