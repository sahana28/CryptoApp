//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 17/08/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingsColumn : Bool
    
    var body: some View {
        HStack {
            leftColumnView
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumnView
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
        
    }
}


struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
//#Preview {
//    CoinRowView(coin: DeveloperInstance.instance.coin, showHoldingsColumn: true)
//}


extension CoinRowView {
    private var leftColumnView : some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerColumn : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingValue.asCurrencyWith2Decimals())
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightColumnView : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? " ")
                .foregroundStyle( (coin.priceChangePercentage24H ?? 0) > 0 ? Color.theme.green : Color.theme.red )
            
        }
        .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
    }
}
