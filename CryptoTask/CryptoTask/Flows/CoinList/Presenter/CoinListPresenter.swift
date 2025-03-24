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
        Task {
            do {
                self.coins = try await repository.fetchCoins(page: 1, pageLimit: self.pageLimit)
                var coinAdapters: [CoinListCellAdapter] = coins.map({ CoinListCellAdapter.coin($0) })
                coinAdapters.append(.loader)
                props = .data(coinAdapters)
            } catch {
                props = .error(error.localizedDescription)
            }
            
        }
    }
    
    //MARK: - CoinListViewOutPut
    
    func retryAction() {
        self.props = .loading
        self.start()
    }
    
    func loadNext() {
        var newPage = currentPage + 1
        Task {
            do {
                let coins = try await repository.fetchCoins(page: newPage, pageLimit: 10)
                self.coins.append(contentsOf: coins)
                var coinAdapters: [CoinListCellAdapter] = self.coins.map({ CoinListCellAdapter.coin($0) })
                coinAdapters.append(.loader)
                self.currentPage = newPage
                self.props = .data(coinAdapters)
            } catch {
                props = .error(error.localizedDescription)
            }
            
        }
    }
}
