//
//  PhoneNumberParseStrategy.swift
//  PhoneNumberParseStrategy
//
//  Created by Mark Thormann on 7/31/21.
//

import Foundation

/// Parse strategy for `PhoneNumber`
public struct PhoneNumberParseStrategy: ParseStrategy {
    
    /// Creates an instance of the `ParseOutput` type from `value`.
    /// - Parameter value: Value to convert to `PhoneNumber` object
    /// - Returns: `PhoneNumber` object
    public func parse(_ value: String) throws -> PhoneNumber {
        // Strip out to just numerics.  Throw out parentheses, etc. and then convert to an array of characters. Simple version here ignores country codes, localized phone numbers, invalid area codes, etc.
        let maxPhoneNumberLength = 10
        let numericValue = Array(value.filter({ $0.isWholeNumber }).prefix(maxPhoneNumberLength))
        
        // PUll out the phone number components
        var areaCode: String = ""
        var exchange: String = ""
        var number: String = ""
        for i in 0..<numericValue.count {
            switch i {
            case 0...2:
                // Area code
                areaCode.append(numericValue[i])
            case 3...5:
                // Exchange
                exchange.append(numericValue[i])
            default:
                // Number
                number.append(numericValue[i])
            }
        }

        // Output the populated object
        return PhoneNumber(areaCode: areaCode, exchange: exchange, number: number)
    }

}
