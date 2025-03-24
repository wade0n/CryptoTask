//
//  CoinDetailView.swift
//
//  Created on 23.03.2025.
//  Copyright © 2025 getsquire.com. All rights reserved.
//

import SwiftUI
import Charts

struct CoinDetailView: View {
    let coin: Coin
    @State private var marketData: MarketData?
    = .init(prices: [
        [1,1], [10, 10] , [20, 20], [30, 30]
    ])

    var body: some View {
        VStack {
            if let marketData = marketData {
                Chart {
                    ForEach(marketData.prices, id: \.self) { price in
                        LineMark(
                            x: .value("Time", price[0]),
                            y: .value("Price", price[1])
                        )
                    }
                }
                .foregroundColor(.red)
                .frame(height: 300)
                .padding()
            } else {
                ProgressView()
            }

            Text(coin.name)
                .font(.title)
            Text("$\(coin.currentPrice, specifier: "%.2f")")
                .font(.headline)
        }
        .navigationTitle(coin.name)
        .padding()
//        .onAppear {
//            CoinGeckoService.shared.fetchMarketData(for: coin.id) { fetchedData in
//                if let fetchedData = fetchedData {
//                    marketData = fetchedData
//                }
//            }
//        }
    }
}
