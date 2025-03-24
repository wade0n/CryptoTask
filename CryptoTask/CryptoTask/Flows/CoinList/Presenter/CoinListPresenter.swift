//
//  CoinListPresenter.swift
//
//  Created on 24.03.2025.
//  Copyright © 2025 getsquire.com. All rights reserved.
//

import Foundation

@Observable
final class CoinListPresenter {
    var props: CoinListProps
    let repository: CoinRepositoryInterface
    
    init(props: CoinListProps = .loading, repository: CoinRepositoryInterface) {
        self.props = props
        self.repository = repository
    }
    
    func start() {
        Task {
            do {
                let coins = try await repository.fetchCoins(page: 1, pageLimit: 10)
                props = .data(coins)
            } catch {
                props = .error(error.localizedDescription)
            }
            
        }
    }
}
