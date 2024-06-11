//
//  String+Extensions.swift
//  MELIApp
//
//  Created by Jorge Menco on 9/06/24.
//

import Foundation

extension String {
    static var empty: String = ""
    
    var isNotEmpty: Bool {
        return  self != .empty
    }
    
    var localizable: String {
        NSLocalizedString(self, comment: "MELI Text")
    }
    
    func toCurrencyFormat(
        decimalCount: Int = 2,
        currencySymbol: String = "$",
        groupingSeparator: String = ",",
        decimalSeparator: String = ".") -> String {
        guard var numericValue = Double(self) else { return String() }

        let fractionDigits: Int = floor(numericValue) != numericValue ? decimalCount : 0
        
        let formatter = buildCurrencyFormatter(
            decimalCount: fractionDigits,
            currencySymbol: currencySymbol,
            groupingSeparator: groupingSeparator,
            decimalSeparator: decimalSeparator)

        numericValue = numericValue < .zero ? numericValue : abs(numericValue)
        return formatter.string(from: NSNumber(value: numericValue)) ?? String()
    }
    
    private func buildCurrencyFormatter(
        decimalCount: Int,
        currencySymbol: String,
        groupingSeparator: String,
        decimalSeparator: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyGroupingSeparator = groupingSeparator
        formatter.currencyDecimalSeparator = decimalSeparator
        formatter.groupingSeparator = groupingSeparator
        formatter.decimalSeparator = decimalSeparator
        formatter.maximumFractionDigits = decimalCount
        formatter.minimumFractionDigits = decimalCount
        formatter.roundingMode = .down

        return formatter
    }
}
