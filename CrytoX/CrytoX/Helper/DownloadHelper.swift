//
//  ViewHelper.swift
//  CrytoX
//
//  Created by junemp on 2022/06/06.
//

import Foundation
import SwiftUI

let apiKey = "XS4Y1FMMNAZJL4RN"

func generateRequestURL(stockSymbol: String) -> String {
    return "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(stockSymbol)&interval=15min&outputsize=full&apikey=\(apiKey)"
}
