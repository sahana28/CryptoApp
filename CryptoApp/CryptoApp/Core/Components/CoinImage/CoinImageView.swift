//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 18/08/24.
//

import SwiftUI


struct CoinImageView: View {
    @StateObject private var viewModel : CoinImageViewModel
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            else if viewModel.isLoading {
                ProgressView()
            }
            else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }

    }
}

#Preview {
    CoinImageView(coin: DeveloperInstance.instance.coin)
        .previewLayout(.sizeThatFits)
}
