//
//  LoadMoreView.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import SwiftUI


struct LoadMoreView: View {
    let message: String
    let loadMoreAction: () -> ()
    
    var body: some View {
        HStack(spacing: 8) {
            ProgressView()
                .frame(width: 44, height: 44)
            Text(message)
                .font(.subheadline)
        }.onAppear {
            loadMoreAction()
        }
    }
}
