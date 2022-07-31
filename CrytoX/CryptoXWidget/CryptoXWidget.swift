//
//  CryptoXWidget.swift
//  CryptoXWidget
//
//  Created by junemp on 2022/07/31.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    
    let widgetDownloadManager = WidgetDownloadManager()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), stockSymbol: "AAPL", stockData: sampleData)
    }

    func getSnapshot(for configuration: AvailableStocksIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), stockSymbol: getStockSymbol(for: configuration), stockData: sampleData)
        completion(entry)
    }

    func getTimeline(for configuration: AvailableStocksIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Task {
            let stockData = try await widgetDownloadManager.downloadJSON(stockSymbol: getStockSymbol(for: configuration))
            let entries = [SimpleEntry(date: Date(), stockSymbol: getStockSymbol(for: configuration), stockData: stockData)]
            let timeline = Timeline(entries: entries, policy: .after(Calendar.current.date(byAdding: .minute, value: 10, to: Date())!))
            completion(timeline)
        }
    }
    
    private func getStockSymbol(for configuration: AvailableStocksIntent) -> String {
        switch configuration.selectedStock {
        case .aAPL:
            return "AAPL"
        case .tSLA:
            return "TSLA"
        case .nFLX:
            return "NFLX"
        case .unknown:
            return "AAPL"
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let stockSymbol: String
    let stockData: [DataEntry]
}

struct CryptoXWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack(alignment: .topLeading) {
            Chart(dataSet: entry.stockData)
            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .center))
                .opacity(0.4)
            Text(entry.stockSymbol)
                .bold()
                .foregroundColor(.white)
                .padding(8)
        }
    }
}

@main
struct CryptoXWidget: Widget {
    let kind: String = "CryptoXWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: AvailableStocksIntent.self , provider: Provider()) { entry in
            CryptoXWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct CryptoXWidget_Previews: PreviewProvider {
    static var previews: some View {
        CryptoXWidgetEntryView(entry: SimpleEntry(date: Date(), stockSymbol: "AAPL", stockData: sampleData))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
