//
//  Coordinator.swift
//
//  Created on 24.03.2025.
//  Copyright © 2025 getsquire.com. All rights reserved.
//

import Foundation
import SwiftUI

final class Coordinator {
    let compositionRoot: CompostionRoot
    
    var root: some View {
        compositionRoot.viewFactory.makeCoinListView().environment(createCointListPresenter())
    }
    
    init(compositionRoot: CompostionRoot) {
        self.compositionRoot = compositionRoot
    }
    
    //MARK: - Private methods.
    
    func createCointListPresenter() -> CoinListPresenter {
        let presenter = CoinListPresenter(repository: compositionRoot.coinRepository)
        presenter.start()
        return presenter
    }
}
