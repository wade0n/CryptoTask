//
//  CoinListPresenter.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation
import SwiftUI

@Observable
final class CoinListPresenter: CoinListViewOutPut {
    
    var props: CoinListProps
    let repository: CoinRepositoryInterface
    private weak var coordinator: Coordinator?
    private var currentPage: Int = 1
    private var pageLimit: Int = 10
    private var coins: [Coin] = []
    
    init(props: CoinListProps = .loading, repository: CoinRepositoryInterface, coordinator: Coordinator?) {
        self.props = props
        self.repository = repository
        self.coordinator = coordinator
        self.start()
    }
    
    func start() {
        loadCoins(page: 1)
    }
    
    //MARK: - CoinListViewOutPut
    
    func retryAction() {
        self.props = .loading
        self.coins = []
        self.start()
    }
    
    func loadNext() {
        loadCoins(page: currentPage + 1)
    }
    
    func detailSelect(for id: String) -> some View {
        coordinator?.createDetailView(coin: coins.first(where: { $0.id == id })!)
    }
    
    // MARK: - Private methods.
    
    func loadCoins(page: Int) {
        Task {
            do {
                let coins = try await repository.fetchCoins(page: page, pageLimit: pageLimit)
                self.coins.append(contentsOf: coins)
                var coinAdapters: [CoinListCellAdapter] = self.coins.map({ CoinListCellAdapter.coin($0) })
                coinAdapters.append(.loader)
                currentPage = page
                props = .data(coinAdapters)
            } catch {
                props = .error(error.localizedDescription)
            }
        }
    }
}
