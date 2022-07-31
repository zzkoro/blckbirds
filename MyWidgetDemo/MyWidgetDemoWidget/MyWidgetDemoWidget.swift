//
//  MyWidgetDemoWidget.swift
//  MyWidgetDemoWidget
//
//  Created by junemp on 2022/07/31.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), secondsElapsed: 10)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), secondsElapsed: 10)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries = [SimpleEntry]()
        let currentDate = Date()
        for secondOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset*10, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, secondsElapsed: secondOffset*10)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let secondsElapsed: Int
}

struct MyWidgetDemoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text("\(entry.secondsElapsed) seconds elapsed")
    }
}

@main
struct MyWidgetDemoWidget: Widget {
    let kind: String = "MyWidgetDemoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetDemoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MyWidgetDemoWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetDemoWidgetEntryView(entry: SimpleEntry(date: Date(), secondsElapsed: 10))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
//            .redacted(reason: .placeholder)
    }
}
