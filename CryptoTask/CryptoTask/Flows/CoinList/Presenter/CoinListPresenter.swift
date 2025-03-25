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
    @ObservationIgnored private weak var router: Coordinator?
    private var currentPage: Int = 1
    private var pageLimit: Int = 10
    private var coins: [Coin] = []
    
    init(props: CoinListProps = .loading, repository: CoinRepositoryInterface, router: Coordinator?) {
        self.props = props
        self.repository = repository
        self.router = router
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
        router?.createDetailView(coin: coins.first(where: { $0.id == id }) ?? coins[0])
    }
    
    // MARK: - Private methods.
    
    private func loadCoins(page: Int) {
        Task {
            do {
                let coins = try await repository.fetchCoins(page: page, pageLimit: pageLimit)
                self.coins.append(contentsOf: coins)
                var coinAdapters: [CoinListCellAdapter] = self.coins.map({ CoinListCellAdapter.coin(createCoinViewModal($0)) })
                coinAdapters.append(.loader)
                currentPage = page
                props = .data(coinAdapters)
            } catch {
                props = .error(error.localizedDescription)
            }
        }
    }
    
    private func createCoinViewModal(_ coin: Coin) -> CoinViewModal {
        .init(id: coin.id, imageURL: coin.image, price: String(format: "$%.2f", coin.currentPrice), name: coin.name, priceChange: getSignedValueFrom(coin.priceChangePercentage24H))
    }
    
    private func getSignedValueFrom(_ value: Double?) -> SignedValue<String>? {
        guard let value else {
            return nil
        }
        
        let stringValue: String = String(format: "%.2f", value) + "%"
        if value > 0 {
            return .positive(stringValue)
        } else {
            return .negative(stringValue)
        }
    }
}
