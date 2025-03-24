//
//  CryptoTaskApp.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 23.03.2025.
//

import SwiftUI

@main
struct CryptoTaskApp: App {
    let coordinator = Coordinator(compositionRoot: CompostionRoot())
    
    var body: some Scene {
        WindowGroup {
            coordinator.root
        }
    }
}
