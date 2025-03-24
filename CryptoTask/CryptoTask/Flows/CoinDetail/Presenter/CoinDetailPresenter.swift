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
        self.start()
    }
    
    func start() {
        fetchGraph(for: coin.id)
    }
    
    // MARK: - Private methods
    private func fetchGraph(for coinId: String) {
        Task {
            do {
                let data = try await repository.fetchGraphPoints(for: coinId)
                var points = [CoinGrapthPoint]()
                let dayOffset = Date().timeIntervalSince1970 - 24 * 60 * 60
                var counter = Double(0)
                for numbers in data.prices {
                    let point = CoinGrapthPoint(time: counter, value: numbers[1])
                   // print(point.time)
                    points.append(point)
                    counter += 1
                }
                
                
                viewModal.graphAdapter = .data(points)
            } catch {
                viewModal.graphAdapter = .error(error.localizedDescription)
            }
        }
    }
}
