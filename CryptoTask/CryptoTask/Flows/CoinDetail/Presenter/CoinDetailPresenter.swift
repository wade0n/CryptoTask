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
    
    // MARK: - Private methods
    private func fetchGraph(for coinId: String) {
        Task {
            do {
                let data = try await repository.fetchGraphPoints(for: coinId)
                var points = [CoinGrapthPoint]()
    
                var maxValue: Double = 0
                var minValue: Double = Double(Int.max)
    
                for numbers in data.prices {
                    let value: Double = numbers[1]
                    if value > maxValue {
                        maxValue = value
                    }
                    if value < minValue {
                        minValue = value
                    }
                    
                    
                    let point = CoinGrapthPoint(date: Date(timeIntervalSince1970: numbers[0]), value: value)
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                    dateFormatter.timeZone = .current

                    print(point.date, "   ", dateFormatter.string(from: point.date))
                    points.append(point)
                }
                
                
                viewModal.graphAdapter = .data(.init(points: points, minValue: minValue, maxValue: maxValue))
            } catch {
                viewModal.graphAdapter = .error(error.localizedDescription)
            }
        }
    }
}
