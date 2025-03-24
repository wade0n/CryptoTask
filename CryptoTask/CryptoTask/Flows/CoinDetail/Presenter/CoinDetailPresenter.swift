//
//  CoinDetailPresenter.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation
import SwiftUI

@Observable
final class CoinDetailPresenter {
    var viewModal: CoinDetailModal
    let repository: CoinRepositoryInterface
    let coin: Coin
    
    init(repository: CoinRepositoryInterface, coin:  Coin) {
        self.repository = repository
        self.coin = coin
        self.viewModal = .init(imageUrlString: coin.image, name: coin.name, graphAdapter: .loading)
    }
    
    func start() {
        fetchGraph(for: coin.id)
    }
    
    //MARK: - Private methods
    private func fetchGraph(for coinId: String) {
        Task {
            do {
                let data = try await repository.fetchGraphPoints(for: coinId)
                var points = [CoinGrapthPoint]()
                let dayOffset = Date().timeIntervalSince1970 - 24 * 60 * 60
                for numbers in data.prices {
                    let point = CoinGrapthPoint(time: numbers[0] - dayOffset, value: numbers[1])
                    points.append(point)
                }
                
                
                viewModal.graphAdapter = .data(points)
            } catch {
                viewModal.graphAdapter = .error(error.localizedDescription)
            }
        }
    }
}
