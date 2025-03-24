//
//  ContentView.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 23.03.2025.
//

import SwiftUI

struct CoinListView: View {
    @State private var coins: [Coin] = [.init(id: "usdId", symbol: "$", name: "USD", currentPrice: 100, priceChangePercentage24H: -20, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")]
    @Environment(CoinListPresenter.self) private var output
    
    
    var body: some View {
        NavigationView {
            switch(output.props) {
            case let .data(coins):
                List(coins) { adapter in
                    switch adapter {
                    case let .coin(coin):
                        NavigationLink(destination: CoinDetailView(coin: coin)) {
                            CoinListCell(coin: coin)
                        }
                    case .loader:
                        LoadMoreView(message: "Loading next") {
                            output.loadNext()
                        }
                    }
                }
            case .loading:
                ProgressView()
            case let .error(message):
                ErrorView(erorrMessage: message) {
                    output.retryAction()
                }
            }
        }

    }
}

#Preview {
    CoinListView().environment(CoinListPresenter(repository: TestCoinRepository()))
}
