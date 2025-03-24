//
//  Coin.swift
//
//  Created on 23.03.2025.
//  Copyright © 2025 getsquire.com. All rights reserved.
//

import Foundation


// MARK: - Coin Model
struct Coin: Identifiable, Decodable {
    let id: String
    let symbol: String
    let name: String
    let currentPrice: Double
    let priceChangePercentage24H: Double?
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case priceChangePercentage24H = "price_change_percentage_24h"
    }
}

// MARK: - Market Data Model
struct MarketData: Decodable {
    let prices: [[Double]]
}
