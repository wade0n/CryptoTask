//
//  CoinRepository.swift
//
//  Created on 24.03.2025.
//  Copyright © 2025 getsquire.com. All rights reserved.
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
