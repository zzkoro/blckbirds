//
//  Extensions.swift
//  CrytoX
//
//  Created by junemp on 2022/07/31.
//

import Foundation

extension Date {
    init(_ dateString: String, dateFormat: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = dateFormat
        dateStringFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval: 0, since: date)
    }
    
    func isInLastNDays(lastDate: Date, dayRange n: Int) -> Bool {
        let startDate = Calendar.current.date(byAdding: .day, value: -n, to: Date())!
        return (min(startDate, lastDate) ... max(startDate, lastDate)).contains(self)
        
//        return (self.compare(startDate) == .orderedDescending || self.compare(startDate) == .orderedSame)
    }
}
