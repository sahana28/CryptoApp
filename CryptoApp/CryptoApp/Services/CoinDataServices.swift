//
//  CoinDataServices.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 17/08/24.
//

import Foundation
import Combine

class CoinDataServices {
    @Published var allCoins : [CoinModel] = []
    var coinSubscription : AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() -> Void {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {  return }
        
        coinSubscription  = NetworkManager.download(from: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder.snakeCaseConverting)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self]  receivedCoins in
                self?.allCoins = receivedCoins
                self?.coinSubscription?.cancel()
            })
        
        
    }
}

extension JSONDecoder {
    static let snakeCaseConverting: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

extension Publisher where Output == Data {
    func decode<T: Decodable>(as type: T.Type = T.self,
        using decoder: JSONDecoder = .snakeCaseConverting) -> Publishers.Decode<Self, T, JSONDecoder> {
        decode(type: type, decoder: decoder)
    }
}
