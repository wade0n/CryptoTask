//
//  CoinRepository.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation

protocol CoinRepositoryInterface: AnyObject {
    func fetchCoins(page: Int, pageLimit: Int) async throws -> [Coin]
    func fetchGraphPoints(for coinId: String) async throws -> MarketData
    func getGrapchCache(for coinId: String) async -> MarketData?
}

actor CoinRepository: CoinRepositoryInterface {
    let networkService: NetworkServiceInterface
    private var cache: [String: MarketData] = [:]
    
    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }
    
    func fetchCoins(page: Int, pageLimit: Int) async throws -> [Coin] {
        try await self.networkService.fetchTopCoins(page: page, pageLimit: pageLimit)
    }
    
    func fetchGraphPoints(for coinId: String) async throws -> MarketData {
        do {
            let graphData = try await self.networkService.fetchMarketData(for: coinId)
            cache[coinId] = graphData
            return graphData
        } catch {
            throw error
        }
    }
    
    func getGrapchCache(for coinId: String) -> MarketData? {
        cache[coinId]
    }
}
