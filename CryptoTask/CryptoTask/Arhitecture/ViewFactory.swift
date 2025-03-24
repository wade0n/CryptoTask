//
//  ViewFactory.swift
//
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation
import SwiftUI

final class ViewFactory {
    public func makeCoinListView() -> some View {
        CoinListView()
    }
    
    public func makeCoinDetailView() -> some View {
        CoinDetailView()
    }
}
