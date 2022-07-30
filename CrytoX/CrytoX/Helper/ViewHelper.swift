//
//  ViewHelper.swift
//  CrytoX
//
//  Created by junemp on 2022/06/06.
//

import Foundation

func getPercentageChange(stockData: [DataEntry]) -> Double {
    if let lastEntryClose = stockData.last?.close,
       let firstEntryClose = stockData.first?.close {
        return ((lastEntryClose - firstEntryClose)/lastEntryClose)*100
    } else {
        return 0
    }
}
