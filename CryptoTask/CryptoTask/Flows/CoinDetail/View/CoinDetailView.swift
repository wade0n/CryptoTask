//
//  CoinDetailView.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import SwiftUI
import Charts

struct CoinDetailView: View {
    @Environment(CoinDetailPresenter.self) private var output

    var body: some View {
        VStack {
            switch output.viewModal.graphAdapter {
            case let .data(points):
                Chart {
                    ForEach(points, id: \.time) { point in
                        LineMark(
                            x: .value("Time", point.time),
                            y: .value("Price", point.value)
                        )
                        .foregroundStyle(.red)
                    }
                }
                .chartYScale(domain: 84_000...90_000)
                .chartXScale(domain: points[0].time...(points.last?.time ?? Double(Int.max)))
//                .foregroundColor(.red)
//                .frame(height: 300)
//                .padding()
            case .loading:
                ProgressView()
            case let .error(message):
                ErrorView(erorrMessage: message) {
                    
                }
            }
            
//            if let marketData = marketData {
//                Chart {
//                    ForEach(marketData.prices, id: \.self) { price in
//                        LineMark(
//                            x: .value("Time", price[0]),
//                            y: .value("Price", price[1])
//                        )
//                    }
//                }
//                .foregroundColor(.red)
//                .frame(height: 300)
//                .padding()
//            } else {
//                ProgressView()
//            }

            Text("$\(output.coin.currentPrice, specifier: "%.2f")")
                .font(.headline)
        }
        .navigationTitle(output.coin.name)
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

#Preview {
    CoinDetailView().environment(CoinDetailPresenter(repository: TestCoinRepository(), coin: .init(id: "dasfasf", symbol: "USD", name: "usdt", currentPrice: 2343, priceChangePercentage24H: 34, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")))
}

