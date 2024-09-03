//
//  MarketDataServices.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 21/08/24.
//

import Foundation
import Combine
import SwiftUI

class MarketDataServices {
    @Published var marketData : MarketDataModel? = nil
    var marketSubscription : AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() -> Void {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {  return }
        
        marketSubscription  = NetworkManager.download(from: url)
            .decode(type: OutputData.self, decoder: JSONDecoder.snakeCaseConverting)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self]  marketData in
                self?.marketData = marketData.data
                self?.marketSubscription?.cancel()
            })
        
        
    }
}
