//
//  CoinListAPI.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import SwiftUI

protocol CoinListViewInput {
    func fill(coins: [Coin])
    func injectDependencies()
}

protocol CoinListViewOutPut {
    associatedtype DetailView: View
    
    func retryAction()
    func loadNext()
    func detailSelect(for id: String) -> DetailView
}


enum CoinListProps {
    case loading
    case error(String)
    case data([CoinListCellAdapter])
}

enum CoinListCellAdapter: Identifiable {
    var id: String {
        switch self {
        case .loader:
            return "someID"
        case .coin(let coin):
            return coin.id
        }
    }
    
    case loader
    case coin(Coin)
}
