//
//  ErrorView.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//
//

import SwiftUI

struct ErrorView: View {
    let erorrMessage: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 16) {
        Image(systemName: "exclamationmark.triangle.fill")
           .font(.largeTitle)
           .foregroundColor(.yellow)
       
       Text("Error Loading Data")
           .font(.headline)
           
       Text(erorrMessage)
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
           
           Button("Retry") {
               retryAction()
           }
           .buttonStyle(.borderedProminent)
       }
       .padding()
       .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
