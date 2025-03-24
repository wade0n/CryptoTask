//
//  ViewFactory.swift
//
//  Created on 24.03.2025.
//  Copyright © 2025 getsquire.com. All rights reserved.
//

import Foundation
import SwiftUI

final class ViewFactory {
    public func makeCoinListView() -> some View {
        CoinListView()
    }
    
    public func makeCoinDetailView(coin: Coin) -> some View {
        CoinDetailView(coin: coin)
    }
}
