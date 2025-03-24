//
//  NetworkService.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//
import Foundation

protocol NetworkServiceInterface: AnyObject {
    func fetchTopCoins(page: Int, pageLimit: Int) async throws -> [Coin]
    func fetchMarketData(for coinId: String) async throws -> MarketData
}


final class NetworkService: NetworkServiceInterface {
    private let baseApi = "https://api.coingecko.com/api/v3"
    
    let urlSession: URLSession
    
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    
    func fetchTopCoins(page: Int, pageLimit: Int) async throws -> [Coin]  {
        let url = URL(string: "\(baseApi)/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=\(pageLimit)&page=\(page)&sparkline=false")!

        let (data, _) = try await URLSession.shared.data(for: constractRequest(url: url))
        return try JSONDecoder().decode([Coin].self, from: data)
    }

    func fetchMarketData(for coinId: String) async throws -> MarketData {
        let url = URL(string: "\(baseApi)/coins/\(coinId)/market_chart?vs_currency=usd&days=1")!
        let (data, _) = try await URLSession.shared.data(for: constractRequest(url: url))
        return try JSONDecoder().decode(MarketData.self, from: data)
    }
    
    
    //MARK: - Private methods.
    private func constractRequest(url: URL) -> URLRequest {
        let token = "CG-Uy8bixUfGMEduCrajWj79aJB"
        let tokenKey = "x-cg-demo-api-key"
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: tokenKey)
        
        return request
    }
}
