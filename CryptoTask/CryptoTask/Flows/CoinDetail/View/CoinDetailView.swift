//
//  CoinDetailView.swift
//
//  Created by Dmitry Kalashnikov on 24.03.2025.
//

import SwiftUI
import Charts

struct CoinDetailView: View {
    @Environment(CoinDetailPresenter.self) private var output

    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: output.viewModal.imageUrlString)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    case .failure:
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.red)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 80, height: 80)
                Text(output.coin.name)
                    .font(.largeTitle)
                Spacer()
            }
            switch output.viewModal.graphAdapter {
            case let .data(modal):
                Chart {
                    ForEach(modal.points, id: \.date) { point in
                        LineMark(
                            x: .value("Time",  point.date),
                            y: .value("$ \(point.value)", point.value)
                        )
                        .foregroundStyle(output.coin.priceChangePercentage24H ?? 0 > 0 ? .green : .red)
                    }
                }
                .chartYScale(domain: modal.minValue...modal.maxValue)
                .chartXScale(domain: modal.points[0].date...(modal.points.last?.date ?? Date()))
                .chartXAxis {
                    AxisMarks(values: .stride(by: .hour, count: 3)) { value in
                        if let date = value.as(Date.self) {
                            let hour = Calendar.current.component(.hour, from: date)
                            switch hour {
                            case 0, 12:
                                AxisValueLabel(format: .dateTime.hour())
                            default:
                                AxisValueLabel(format: .dateTime.hour(.defaultDigits(amPM: .omitted)))
                            }
                            
                            AxisGridLine()
                            AxisTick()
                        }
                    }
                }
                .frame(width: 350, height: 200)
                .padding(32)
            case .loading:
                ProgressView()
            case let .error(message):
                ErrorView(erorrMessage: message) {
                    
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            output.start()
        }
    }
}

#Preview {
    CoinDetailView().environment(CoinDetailPresenter(repository: TestCoinRepository(), coin: .init(id: "dasfasf", symbol: "USD", name: "usdt", currentPrice: 2343, priceChangePercentage24H: 34, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")))
}

