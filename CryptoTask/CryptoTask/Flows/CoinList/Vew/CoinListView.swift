//
//  ContentView.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 23.03.2025.
//

import SwiftUI

protocol CoinListViewInput {
    func fill(coins: [Coin])
    func injectDependencies()
}

protocol CoinListViewOutPut {
    
}


enum CoinListProps {
    case loading
    case error(String)
    case data([Coin])
}

struct CoinListView: View {
    @State private var coins: [Coin] = [.init(id: "usdId", symbol: "$", name: "USD", currentPrice: 100, priceChangePercentage24H: -20, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")]
    @Environment(CoinListPresenter.self) private var output
    
    
    var body: some View {
        NavigationView {
            switch(output.props) {
            case let .data(coins):
                List(coins) { coin in
                    NavigationLink(destination: CoinDetailView(coin: coin)) {
                        HStack {
                            // Coin Icon
                            AsyncImage(url: URL(string: coin.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                case .failure:
                                    Image(systemName: "xmark.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 30, height: 30)
                            
                            // Coin Details
                            VStack(alignment: .leading) {
                                Text(coin.name)
                                    .font(.headline)
                                Text("$\(coin.currentPrice, specifier: "%.2f")")
                                    .font(.subheadline)
                            }
                            Spacer()
                            if let percentageChange = coin.priceChangePercentage24H {
                                Text("\(percentageChange, specifier: "%.2f")%")
                                    .foregroundColor(percentageChange > 0 ? .green : .red)
                            }
                        }
                    }.navigationTitle("Top Coins")
                }
            case .loading, .error:
                ProgressView()
            }
        }

    }
}

#Preview {
    CoinListView().environment(CoinListPresenter(repository: TestCoinRepository()))
}
