//
//  HomeViewModel.swift
//  CryptoSwiftUI
//
//  Created by Phuc Huu Do on 7/3/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var statistics: [StatisticModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private let dataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] filterdCoins in
                self?.allCoins = filterdCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map(parseMarketData)
            .sink { [weak self] data in
                self?.statistics = data
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        print("Run filter coins: \(text), coins: \(coins)")
        guard !text.isEmpty else { return coins }
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func parseMarketData(data: MarketDataModel?) -> [StatisticModel] {
        var stats = [StatisticModel]()
        guard let data = data else { return stats }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "Volume", value: data.volumn)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolioValue = StatisticModel(title: "Portfolio Value", value: "$000", percentageChange: 0)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolioValue
        ])
        return stats
    }
}
