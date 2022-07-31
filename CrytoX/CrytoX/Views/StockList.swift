//
//  StockList.swift
//  CrytoX
//
//  Created by junemp on 2022/05/26.
//

import SwiftUI

struct StockList: View {
    var body: some View {
        NavigationView {
            List {
                StockListRow(downloadManager: DownloadManager(stockSymbol: "AAPL"), stockSymbol: "AAPL", stockName: "Apple, Inc.")
            }
            .listStyle(.plain)
            .navigationTitle("StockX")
        }
    }
}

struct StockList_Previews: PreviewProvider {
    static var previews: some View {
        StockList()
    }
}

struct StockListRow: View {
    
    @ObservedObject var downloadManager: DownloadManager
    let stockSymbol: String
    let stockName: String
    
    var body: some View {
        HStack {
            NavigationLink(destination: ContentView(downloadManager: downloadManager, stockSymbol: stockSymbol)) {
                VStack(alignment: .leading) {
                    Text(stockSymbol)
                        .font(.custom("Avenir", size:20))
                        .fontWeight(.medium)
                    Text(stockName)
                        .font(.custom("Avenir", size:16))
                }.background(Color.purple)
                Spacer()
                if downloadManager.dataFetched {
                    VStack(alignment: .trailing) {
                        Text(String(format: "%.2f", getPercentageChange(stockData: downloadManager.dailyEntries)) + "%")
                            .font(.custom("Avenir", size:14))
                            .fontWeight(.medium)
                            .foregroundColor(getPercentageChange(stockData: downloadManager.dailyEntries) < 0 ? .red : .green)
                        Text("$" + String(format: "%.2f", downloadManager.dailyEntries.last?.close ?? 0))
                            .font(.custom("Avenir", size:26))
                    }
                    .background(Color.blue)
                }
            }
        }
    }
}
