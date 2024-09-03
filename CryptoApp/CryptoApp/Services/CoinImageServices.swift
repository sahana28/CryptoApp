//
//  CoinImageServices.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 18/08/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageServices {
    @Published var coinImage : UIImage? = nil
    let coin : CoinModel
    private let fileManager = LocalFileManager.instance
    var imageSubscription : AnyCancellable?
    private let folderName = "coin_images"
    
    init(coin : CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, foldderName: folderName) {
            coinImage = savedImage
            print("Retrieved image from File Manager")
        }
        else {
            downloadCoinImage()
            
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {  return }
        imageSubscription  = NetworkManager.download(from: url)
            .tryMap({ (data) -> UIImage in
                return UIImage(data: data)!
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] receivedImage in
                guard let self = self else { return }
                self.coinImage = receivedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: receivedImage, imageName: coin.id, folderName: folderName)
            })
        
    }
}
