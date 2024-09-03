//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 16/08/24.
//

import Foundation
//JSON 
/* CoinGecko API Info
 URL : https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 JSON Response :
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 58459,
     "market_cap": 1154649708411,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1228311489974,
     "total_volume": 33349708198,
     "high_24h": 59834,
     "low_24h": 56647,
     "price_change_24h": 197.45,
     "price_change_percentage_24h": 0.33889,
     "market_cap_change_24h": 3606221360,
     "market_cap_change_percentage_24h": 0.3133,
     "circulating_supply": 19740631,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 73738,
     "ath_change_percentage": -20.79319,
     "ath_date": "2024-03-14T07:10:36.635Z",
     "atl": 67.81,
     "atl_change_percentage": 86032.32247,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2024-08-16T08:49:00.590Z",
     "sparkline_in_7d": {
      "price": [
         60935.99484313054,
         60842.721465040064,
         60894.232083015864,
         60958.824053964636,
         60932.02359297336,
         61211.045261694686,
         61376.73740019104,
         60862.17994470777,
         60901.35189172805,
         60755.24024762029,
         60289.44581145123,
         60318.613294064446,
         60300.558880810284,
         60394.12509145167,
         60308.28537322583,
         60517.9067058922,
         60532.15699045179,
         60383.66005871233,
         60519.48661932766,
         60827.69960219288,
         60818.06398338679,
         60660.07504007888,
         60614.946036560636,
         60862.643450316245,
         60946.07087640283,
         61072.64188640716,
         61116.742598936595,
         61259.24572953686,
         61041.90203746067,
         61045.00293514066,
         60816.78517998003,
         61100.04239140031,
         61119.04206361144,
         61266.49135181372,
         61566.22627047148,
         61883.72524061102,
         63034.25197975495,
         63306.926239253815,
         63771.186594942046,
         63673.43203996905,
         64367.731453455875,
         64183.40662601132,
         64162.36575527889,
         63936.837036734,
         63905.614348637326,
         64034.758841340714,
         63962.84668451357,
         63932.554341758856,
         63976.29051995182,
         64231.201414131196,
         64310.62330987425,
         64266.71314472571,
         64358.60916887261,
         64135.95102342594,
         64120.87993123906,
         64131.99005024106,
         64145.82498319456,
         64075.42833552749,
         64007.333394978436,
         64250.14964502494,
         64177.82268716298,
         64274.542576046464,
         64268.82714724803,
         64152.90757050182,
         63978.09316734037,
         63966.96652548775,
         64187.06046280384,
         64348.38141951863,
         64189.237324505426,
         64179.32668855927,
         64058.06992713776,
         64226.14643976747,
         64193.39226786866,
         63986.98426792576,
         63890.019395367206,
         63914.83460227322,
         63899.35295347262,
         63994.01727917139,
         63875.82753563255,
         63978.71637618148,
         64174.04585508156,
         64184.878478399085,
         64160.99778877754,
         64146.798312548526,
         64162.22727642108,
         64206.79942164749,
         64175.52726249115,
         64404.26476403028,
         64648.01695080237,
         64668.10743447946,
         64161.86255348353,
         64232.150789389576,
         63970.52896510488,
         64061.22024001037,
         64103.0117295644,
         64066.217642792566,
         63899.92754087854,
         63832.970159577926,
         63861.89002499945,
         63699.15704866862,
         63924.41283700123,
         63836.73883798777,
         63933.82328931946,
         63576.318664383034,
         63347.36179059262,
         63256.05299398837,
         63611.32880563979,
         63682.379967191926,
         63301.11051602876,
         63519.18096059275,
         63295.24366746738,
         63413.572298013576,
         63181.365739458604,
         63119.02250734977,
         62895.08768907413,
         62772.132112030995,
         63182.52894576545,
         62964.425406138565,
         62952.1483185441,
         63094.222435720454,
         63094.93332246692,
         62820.70066831279,
         62963.725937114476,
         62938.23472187073,
         62636.72904660048,
         62342.351028152814,
         62414.3028097667,
         62345.68316193942,
         61997.40460142618,
         61706.881850262966,
         61634.397442733774,
         61590.456694191744,
         62122.99726349206,
         62055.9385443653,
         61976.35043057527,
         61880.77743116783,
         58059.84861092541,
         59199.34377628683,
         59327.70016611258,
         59068.14960627904,
         59350.03164630776,
         59393.97272044696,
         59540.15462779536,
         59314.30659526362,
         59311.718191981694,
         59133.2959120745,
         58855.44458712857,
         59249.55718246931,
         59962.807975995434,
         60036.74366489448,
         59975.089209228616,
         59911.80578953989,
         59834.19240912646,
         59279.720383328626,
         58647.12822514628,
         59051.92884979606,
         59130.399820034385,
         59474.803468164886,
         59005.65986453745,
         59189.98525990052,
         58976.77731506606,
         59097.842954811764,
         59143.100335965435,
         59174.92838635156,
         59157.83586486874,
         59157.24129661261,
         59201.98149280982,
         59151.2373090962
       ]
     },
     "price_change_percentage_24h_in_currency": 0.3388949358499444
   },
 */

struct CoinModel : Identifiable, Codable {
    
    let id, symbol, name: String
    let image: String
    let currentPrice : Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings : Double?
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingValue : Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank : Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}

