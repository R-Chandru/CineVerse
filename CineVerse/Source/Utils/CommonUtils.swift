//
//  StringUtils.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import Foundation
import UIKit

let HorizontalPadding: CGFloat = 16
let VerticalPadding: CGFloat = 10

enum CommonUtils {
    
    static func getNonOptionalString<T>(_ values: T?...) -> String where T: LosslessStringConvertible {
        for value in values {
            if let unwrapped = value {
                return String(describing: unwrapped)
            }
        }
        return ""
    }
    
    
    static func decimalToPercentage(_ decimal: Double) -> CGFloat {
        let percentage = CGFloat(Int(decimal * 10))
        return percentage
    }
    
    
    // "Titanic" will be semibold and "(1997)" lite
    static func getTitleFormatString(with title: String, additionalText: String) -> NSMutableAttributedString {
        let titanicString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24.0)])
        let yearString = NSAttributedString(string: additionalText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)])
        
        let combinedString = NSMutableAttributedString(attributedString: titanicString)
        combinedString.append(NSAttributedString(string: " "))
        combinedString.append(yearString)
        
        return combinedString
    }
    
    
    static func getLanguageName(fromCode code: String?) -> String? {
        guard let code else {
            return nil
        }
        let locale = Locale(identifier: code)
        return locale.localizedString(forLanguageCode: code)
    }
    
    
    static func formatCurrency(amount: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2
        
        let doubleAmount = Double(amount)
        return formatter.string(from: NSNumber(value: doubleAmount))
    }

}
