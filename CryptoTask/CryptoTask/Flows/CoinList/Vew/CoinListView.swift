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
        NavigationStack {
            switch(output.props) {
            case let .data(coins):
                List(coins) { adapter in
                    switch adapter {
                    case let .coin(coin):
                        NavigationLink(value: coin.id , label: {
                            CoinListCell(coin: coin)
                        })
                    case .loader:
                        LoadMoreView(message: "Loading next") {
                            output.loadNext()
                        }
                    }
                }
                .navigationDestination(for: String.self) { identifier in
                    output.detailSelect(for:  identifier)
                }
                .navigationTitle("Top coins")
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
