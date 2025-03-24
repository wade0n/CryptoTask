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
    
    init(props: CoinListProps = .loading, repository: CoinRepositoryInterface) {
        self.props = props
        self.repository = repository
        self.start()
    }
    
    func start() {
        Task {
            do {
                let coins = try await repository.fetchCoins(page: 1, pageLimit: 10)
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
        
    }
}
