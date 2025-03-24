//
//  CoinRepository.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation

protocol CoinRepositoryInterface: AnyObject {
    func fetchCoins(page: Int, pageLimit: Int) async throws -> [Coin]
}

final class CoinRepository: CoinRepositoryInterface {
    let networkService: NetworkServiceInterface
    
    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }
    
    func fetchCoins(page: Int, pageLimit: Int) async throws -> [Coin] {
        try await self.networkService.fetchTopCoins(page: page, pageLimit: pageLimit)
    }
}
