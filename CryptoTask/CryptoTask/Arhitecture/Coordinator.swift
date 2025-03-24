//
//  Coordinator.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import Foundation
import SwiftUI

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
        let presenter = CoinListPresenter(repository: compositionRoot.coinRepository)
        return compositionRoot.viewFactory.makeCoinListView().environment(presenter)
    }
}
