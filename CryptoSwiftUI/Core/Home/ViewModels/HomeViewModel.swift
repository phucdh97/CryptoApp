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
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title1", value: "value1", percentageChange: 10.0)
        , StatisticModel(title: "Title2", value: "value2")
        , StatisticModel(title: "Title3", value: "value 3", percentageChange: -4.0)
        , StatisticModel(title: "Title4", value: "value4")
    ]
    
    private var cancellables: Set<AnyCancellable> = []
    private let dataService = CoinDataService()
    
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
}
