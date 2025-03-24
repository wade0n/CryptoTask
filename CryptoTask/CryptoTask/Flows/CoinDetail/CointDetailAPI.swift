//
//  CointDetailAPi.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation

struct CoinGrapthPoint: Hashable {
    let date: Date
    let value: Double
}

struct CoinGraphModal {
    let points: [CoinGrapthPoint]
    let minValue: Double
    let maxValue: Double
}

enum CointDetailGraphAdapter {
    case data(CoinGraphModal)
    case loading
    case error(String)
}

struct CoinDetailModal {
    let imageUrlString: String
    let name: String
    var graphAdapter: CointDetailGraphAdapter
}
