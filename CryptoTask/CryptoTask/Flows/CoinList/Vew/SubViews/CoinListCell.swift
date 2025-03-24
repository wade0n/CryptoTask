//
//  CoinListCell.swift
//  CryptoTask
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import SwiftUI

struct CoinListCell: View {
    let coin: Coin
    
    var body: some View {
            HStack {
                AsyncImage(url: URL(string: coin.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    case .failure:
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 30, height: 30)
                
                VStack(alignment: .leading) {
                    Text(coin.name)
                        .font(.headline)
                    Text("$\(coin.currentPrice, specifier: "%.2f")")
                        .font(.subheadline)
                }
                Spacer()
                if let percentageChange = coin.priceChangePercentage24H {
                    Text("\(percentageChange, specifier: "%.2f")%")
                        .foregroundColor(percentageChange > 0 ? .green : .red)
                }
            }
    }
}
