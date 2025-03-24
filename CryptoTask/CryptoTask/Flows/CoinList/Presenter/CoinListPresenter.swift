//
//  CoinListPresenter.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation

@Observable
final class CoinListPresenter: CoinListViewOutPut {
    var props: CoinListProps
    let repository: CoinRepositoryInterface
    private var currentPage: Int = 1
    private var pageLimit: Int = 10
    private var coins: [Coin] = []
    
    init(props: CoinListProps = .loading, repository: CoinRepositoryInterface) {
        self.props = props
        self.repository = repository
        self.start()
    }
    
    func start() {
        loadCoins(page: 1)
    }
    
    //MARK: - CoinListViewOutPut
    
    func retryAction() {
        self.props = .loading
        self.start()
    }
    
    func loadNext() {
        loadCoins(page: currentPage + 1)
    }
    
    // MARK: - Private methods.
    
    func loadCoins(page: Int) {
        Task {
            do {
                let coins = try await repository.fetchCoins(page: page, pageLimit: pageLimit)
                self.coins.append(contentsOf: coins)
                var coinAdapters: [CoinListCellAdapter] = self.coins.map({ CoinListCellAdapter.coin($0) })
                coinAdapters.append(.loader)
                self.currentPage = page
                self.props = .data(coinAdapters)
            } catch {
                props = .error(error.localizedDescription)
            }
            
        }
    }
}
