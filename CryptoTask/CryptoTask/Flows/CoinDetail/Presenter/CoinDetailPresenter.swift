//
//  CoinDetailPresenter.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation
import SwiftUI

@Observable
final class CoinDetailPresenter: CoinDetailOutPut {
    var viewModal: CoinDetailModal
    private let repository: CoinRepositoryInterface
    private let coin: Coin
    
    init(repository: CoinRepositoryInterface, coin:  Coin) {
        self.repository = repository
        self.coin = coin
        self.viewModal = .init(imageUrlString: coin.image, name: coin.name, graphAdapter: .loading)
    }
    
    func start() {
        Task {
            if let cachedData = await repository.getGrapchCache(for: coin.id) {
                let modal = prepareGraphData(data: cachedData)
                await MainActor.run {
                    self.viewModal.graphAdapter = .data(modal)
                }
            }
        }
        fetchGraph(for: coin.id)
    }
    
    // MARK: - Private methods
    private func fetchGraph(for coinId: String) {
        Task {
            let graphAdapter: CointDetailGraphAdapter
            
            do {
                let data = try await repository.fetchGraphPoints(for: coinId)
                let modal = prepareGraphData(data: data)
                
                graphAdapter = .data(modal)
            } catch {
                graphAdapter = .error(error.localizedDescription)
            }
            
            await MainActor.run {
                self.viewModal.graphAdapter = graphAdapter
            }
        }
    }
    
    private func prepareGraphData(data: MarketData) -> CoinGraphModal {
        var points = [CoinGrapthPoint]()

        var maxValue: Double = 0
        var minValue: Double = Double(Int.max)
        for numbers in data.prices where numbers.count >= 2 {
            let value: Double = numbers[1]
            let timestamp = numbers[0]
            if value > maxValue {
                maxValue = value
            }
            if value < minValue {
                minValue = value
            }
            
            /// timestamp from backAPI is in miliseconds, should convert it to seconds.
            let point = CoinGrapthPoint(date: Date(timeIntervalSince1970: timestamp/1000), value: value)
           
            points.append(point)
        }
        
        return .init(
            points: points,
            minValue: minValue,
            maxValue: maxValue,
            isNegative: points.first?.value ?? 0 >= points.last?.value ?? 0
        )
    }
}
