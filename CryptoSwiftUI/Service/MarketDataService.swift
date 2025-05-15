//
//  MarketDataService.swift
//  CryptoSwiftUI
//
//  Created by Do Huu Phuc on 27/4/25.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel?
    private var marketDataSubscription: AnyCancellable?
    
    init () {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] GlobalData in
                guard let self = self else { return }
                self.marketData = GlobalData.data
                self.marketDataSubscription?.cancel()
            })
    }
}

