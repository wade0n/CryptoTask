//
//  CointDetailAPi.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation

struct CoinGrapthPoint: Hashable {
    let time: Double
    let value: Double
}

enum CointDetailGraphAdapter {
    case data([CoinGrapthPoint])
    case loading
    case error(String)
}

struct CoinDetailModal {
    let imageUrlString: String
    let name: String
    var graphAdapter: CointDetailGraphAdapter
}
