//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 18/08/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    
    private let coin : CoinModel
    private let coinImageService : CoinImageServices
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        coinImageService = CoinImageServices(coin: coin)
        addSubscribers()
        isLoading = true
        
    }
    
    private func addSubscribers() {
        coinImageService.$coinImage
            .sink { [weak self] image in
                self?.isLoading = false
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
