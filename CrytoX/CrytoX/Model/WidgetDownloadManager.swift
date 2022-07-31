//
//  DownloadManager.swift
//  CrytoX
//
//  Created by junemp on 2022/07/31.
//

import Foundation
import SwiftUI

class WidgetDownloadManager {

    
    enum FetchError: Error {
        case badURL
        case badEntries
    }
    
    func downloadJSON(stockSymbol: String) async throws -> [DataEntry] {
        
        var dataEntries = [DataEntry]()
        
        guard let url = URL(string: generateRequestURL(stockSymbol: stockSymbol)) else { throw FetchError.badURL }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let parsedJSON = try JSONDecoder().decode(TimeSeriesJSON.self, from: data)
        
        for timeSeries in parsedJSON.timeSeries {
            dataEntries.append(DataEntry(date: Date(timeSeries.key, dateFormat: "yyyy-MM-dd HH:mm:ss"), close: (timeSeries.value.close as NSString).doubleValue))
        }
        
        if dataEntries.count == parsedJSON.timeSeries.count {
            dataEntries.sort(by: {$0.date.compare($1.date) == .orderedAscending})
        }
        
        guard let lastDateOfData = dataEntries.last?.date else { throw FetchError.badEntries }
        
        print("lastDateOfData: \(lastDateOfData)")
        
        var filteredEntries = [DataEntry]()
        
        for entry in dataEntries {
            if Calendar.current.isDate(entry.date, equalTo: lastDateOfData, toGranularity: .day) {
                filteredEntries.append(entry)
            }
        }
        
        dataEntries = filteredEntries
        
        return dataEntries
        
    }
    
    
}
