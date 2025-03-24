//
//  ContentView.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 23.03.2025.
//

import SwiftUI

struct CoinListView: View {
    @Environment(CoinListPresenter.self) private var output
    
    var body: some View {
        NavigationView {
            switch(output.props) {
            case let .data(coins):
                List(coins) { adapter in
                    switch adapter {
                    case let .coin(coin):
                        NavigationLink(destination: output.detailSelect(for: coin.id)) {
                            CoinListCell(coin: coin)
                        }
                    case .loader:
                        LoadMoreView(message: "Loading next") {
                            output.loadNext()
                        }
                    }
                }.navigationTitle("Top coins")
            case .loading:
                ProgressView()
            case let .error(message):
                ErrorView(erorrMessage: message) {
                    output.retryAction()
                }
            }
        }
        .onAppear {
            output.start()
        }

    }
}

#Preview {
    CoinListView().environment(CoinListPresenter(repository: TestCoinRepository(), router: nil))
}
