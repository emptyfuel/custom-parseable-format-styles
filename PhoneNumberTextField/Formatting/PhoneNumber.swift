//
//  PhoneNumber.swift
//  PhoneNumber
//
//  Created by Mark Thormann on 8/13/21.
//

import Foundation

/// Representation of U.S. phone number
public struct PhoneNumber {
    
    /// Area code
    public var areaCode: String
    
    /// First three digits of a 7-digit phone number
    public var exchange: String
    
    /// Last four digits of a 7-digit phone number
    public var number: String
    
    /// Constructor
    /// - Parameters:
    ///   - areaCode: Area code
    ///   - exchange: First three digits of a 7-digit phone number
    ///   - number: Last four digits of a 7-digit phone number
    public init(areaCode: String, exchange: String, number: String) {
        self.areaCode = areaCode
        self.exchange = exchange
        self.number = number
    }
    
}

public extension PhoneNumber {
    
    /// Get a formatted string from a format style
    /// - Parameter formatStyle: Phone number format style
    /// - Returns: Formatted string
    func formatted(_ formatStyle: PhoneNumberFormatStyle) -> String {
        formatStyle.format(self)
    }
    
}
