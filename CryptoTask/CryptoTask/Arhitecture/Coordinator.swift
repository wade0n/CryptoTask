//
//  Coordinator.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation
import SwiftUI

//protocol DetailCoinRouter: AnyObject {
//    func createDetailView(coin: Coin) -> CoinDetailView
//}

final class Coordinator {
    let compositionRoot: CompostionRoot
    
    var root: some View {
        createCointListView()
    }
    
    init(compositionRoot: CompostionRoot) {
        self.compositionRoot = compositionRoot
    }
    
    //MARK: - Private methods.
    
    func createCointListView() -> some View {
        let presenter = CoinListPresenter(repository: compositionRoot.coinRepository, router: self)
        return compositionRoot.viewFactory.makeCoinListView().environment(presenter)
    }
    
    func createDetailView(coin: Coin) -> some View {
        compositionRoot.viewFactory.makeCoinDetailView(coin: coin)
    }
    
}
