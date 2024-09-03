//
//  PreviewProvider.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 17/08/24.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev : DeveloperInstance {
        return DeveloperInstance.instance
    }
}

class DeveloperInstance {
    static let instance = DeveloperInstance()
    private init() {}
    
    let viewModel = HomeViewModel()
    let statsModel1 = StatisticsModel(title: "Market Cap", value: "$2.55 Tr", percentageChange: 0.06)
    let statsModel2 = StatisticsModel(title: "Market Cap", value: "$2.55 Tr")
    let statsModel3 = StatisticsModel(title: "Market Cap", value: "$2.55 Tr",percentageChange: -1.5)
    
   let coin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        currentPrice: 61408,
        marketCap: 1141731099010,
        marketCapRank: 1,
        fullyDilutedValuation: 1285385611303,
        totalVolume: 67190952980,
        high24H: 61712,
        low24H: 56220,
        priceChange24H: 3952.64,
        priceChangePercentage24H: 6.87944,
        marketCapChange24H: 72110681879,
        marketCapChangePercentage24H: 6.74171,
        circulatingSupply: 18653043,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 61712,
        athChangePercentage: -0.97589,
        athDate: "2021-03-13T20:49:26.606Z",
        atl: 67.81,
        atlChangePercentage: 90020.24075,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2021-03-13T23:18:10.268Z",
        sparklineIn7D: SparklineIn7D(price: [
            54019.26878317463,
            53718.060935791524,
            53677.12968669343,
            53848.3814432924,
            53561.593235320615,
            53456.0913723206,
            53888.97184353125,
            54796.37233913172,
            54593.507358383504,
            54582.558599307624,
            54635.7248282177,
            54772.612788430226,
            55192.54513921453,
            54878.11598538206,
            54513.95881205807,
            55013.68511841942,
            55145.89456844788,
            54718.37455337104,
            54954.0493828267,
            54910.13413954234,
            54778.58411728141,
            55027.87934987173,
            55473.0657777974,
            54997.291345118225,
            54991.81484262107,
            55395.61328972238,
            55530.513360661644,
            55344.4499292381,
            54889.00473869075,
            54844.521923521665,
            54710.03981625522,
            54135.005312343856,
            54278.51586384954,
            54255.871982023025,
            54346.240757736465,
            54405.90449526803,
            54909.51138548527,
            55169.3372715675,
            54810.85302834732,
            54696.044114623706,
            54332.39670114743,
            54815.81007775886,
            55013.53089568202,
            54856.867125138066,
            55090.76841223987,
            54524.41939124773,
            54864.068334250915,
            54462.38634298567,
            54810.6138506792,
            54763.5416402156,
            54621.36137575708,
            54513.628030530825,
            54356.00127005116,
            53755.786684715764,
            54024.540451750094,
            54385.912857981304,
            54399.67618552436,
            53991.52168768531,
            54683.32533920595,
            54449.31811384671,
            54409.102042970466,
            54370.86991701537,
            53731.669170540394,
            53645.37874343392,
            53841.45014070333,
            53078.52898275558,
            52881.63656182149,
            57210.138362768965,
            56805.27815017699,
            56682.3217648727,
            57043.194415417776,
            56912.77785094373,
            56786.15869001341,
            57003.56072100917,
            57166.66441986013,
            57828.511814425874,
            57727.41272216753,
            58721.7528896422,
            58167.84861375856,
            58180.50145658414,
            58115.72142404893,
            58058.65960870684,
            57831.48061892176,
            57430.1839517489,
            56969.140564644826,
            57154.57504790339,
            57336.828870254896

        ]),
        priceChangePercentage24HInCurrency: 3952.64,
        currentHoldings: 1.5)
    
}
