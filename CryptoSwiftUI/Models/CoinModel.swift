//
//  CoinModel.swift
//  CryptoSwiftUI
//
//  Created by Phuc Huu Do on 26/2/25.
//

import Foundation

/*
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=vnd&order=market_cap_desc&per_page=250&sparkline=true&price_change_percentage=24h
 
 
 {
         "id": "bitcoin",
         "symbol": "btc",
         "name": "Bitcoin",
         "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
         "current_price": 2273463922,
         "market_cap": 45101105855325832,
         "market_cap_rank": 1,
         "fully_diluted_valuation": 45101212756092320,
         "total_volume": 2156175650056258,
         "high_24h": 2346190612,
         "low_24h": 2197842198,
         "price_change_24h": -69869507.01189518,
         "price_change_percentage_24h": -2.98163,
         "market_cap_change_24h": -1.427781054831808e+15,
         "market_cap_change_percentage_24h": -3.06859,
         "circulating_supply": 19829156.0,
         "total_supply": 19829203.0,
         "max_supply": 21000000.0,
         "ath": 2755110671,
         "ath_change_percentage": -17.48019,
         "ath_date": "2025-01-20T09:11:54.494Z",
         "atl": 3672339,
         "atl_change_percentage": 61809.09695,
         "atl_date": "2015-01-14T00:00:00.000Z",
         "roi": null,
         "last_updated": "2025-02-26T04:46:47.974Z",
         "sparkline_in_7d": {
             "price": [
                 95613.70786478418,
                 95280.7459174621,
                 95317.50472754847,
                 95727.74865208809,
                 95665.49231937547,
                 95176.94369782117,
                 95224.12571943826,
                 95586.35220471295,
                 89006.72620143932
             ]
         },
         "price_change_percentage_24h_in_currency": -2.9816289119216752
     }
 */

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double?
    let marketCapRank: Double?
    let fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHolding(_ value: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: value)
    }
    
    var currentHoldingValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
