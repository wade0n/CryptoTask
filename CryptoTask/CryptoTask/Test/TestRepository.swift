//
//  TestRepository.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation

enum TestError: Error {
    case errorStub
}

final class TestCoinRepository: CoinRepositoryInterface {
    func fetchCoins(page: Int, pageLimit: Int) async throws -> [Coin] {
        [ .init(id: "usdId", symbol: "$", name: "USD", currentPrice: 100, priceChangePercentage24H: -20, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"),
          .init(id: "usdId", symbol: "$", name: "USD", currentPrice: 100, priceChangePercentage24H: -20, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"),
          .init(id: "usdId", symbol: "$", name: "USD", currentPrice: 100, priceChangePercentage24H: -20, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"),
          .init(id: "usdId", symbol: "$", name: "USD", currentPrice: 100, priceChangePercentage24H: -20, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"),
          .init(id: "usdId", symbol: "$", name: "USD", currentPrice: 100, priceChangePercentage24H: -20, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")]
//        throw TestError.errorStub
    }
}


