//
//  CointDetailAPi.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation


/// These is contract between View and Presenter.
/// Here is ViewModal and protocols.
///
struct CoinGrapthPoint: Hashable {
    let date: Date
    let value: Double
}

struct CoinGraphModal {
    let points: [CoinGrapthPoint]
    let minValue: Double
    let maxValue: Double
    let isNegative: Bool
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

protocol CoinDetailOutPut: AnyObject {
    func start()
}
