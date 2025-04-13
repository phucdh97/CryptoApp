//
//  HomeViewModel.swift
//  CryptoSwiftUI
//
//  Created by Phuc Huu Do on 7/3/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoints: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
        }
    }
}
