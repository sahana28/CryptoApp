//
//  Date.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 29/08/24.
//

import Foundation

extension Date {
    
    init(coinGeckoDateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoDateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        shortFormatter.string(from: self)
    }
}
