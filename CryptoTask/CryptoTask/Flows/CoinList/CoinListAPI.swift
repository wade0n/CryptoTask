//
//  CoinListAPI.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import SwiftUI

/// These is contract between View and Presenter.
/// Here is ViewModal and protocols.

protocol CoinListViewOutPut {
    associatedtype DetailView: View
    
    func retryAction()
    func loadNext()
    func detailSelect(for id: String) -> DetailView
    func start()
}

enum SignedValue<T> {
    case positive(T)
    case negative(T)
    
    var value: T {
        switch self {
        case let .positive(value):
            return value
        case let .negative(value):
            return value
        }
    }
    
    func isNegative() -> Bool {
        switch self {
        case .positive:
            return false
        case .negative:
            return true
        }
    }
}

struct CoinViewModal: Identifiable {
    let id: String
    let imageURL: String
    let price: String
    let name: String
    let priceChange: SignedValue<String>?
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
    case coin(CoinViewModal)
}
