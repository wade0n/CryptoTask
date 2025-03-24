//
//  CompositionRoot.swift
//
//  Created on 24.03.2025.
//  Copyright © 2025 getsquire.com. All rights reserved.
//

import Foundation

final class CompostionRoot {
    let networkService: NetworkServiceInterface
    let viewFactory: ViewFactory = .init()
    
    lazy var coinRepository: CoinRepositoryInterface = CoinRepository(networkService: networkService)
    
    init() {
        let session =  URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
        networkService = NetworkService(urlSession: session)
    }
}
