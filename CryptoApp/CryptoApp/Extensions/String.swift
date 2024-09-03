//
//  String.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 30/08/24.
//

import Foundation


extension String {
    
    var removingHTMLOccurences : String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression, range: nil)
    }
}
