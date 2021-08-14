//
//  PhoneNumberFormatStyle.swift
//  PhoneNumberFormatStyle
//
//  Created by Mark Thormann on 7/31/21.
//

import Foundation

public extension FormatStyle where Self == PhoneNumber.PhoneNumberFormatStyle {
    
    /// Format the given string as a phone number in the format (___) ___-____ or similar
    static var phoneNumber: PhoneNumber.PhoneNumberFormatStyle {
        PhoneNumber.PhoneNumberFormatStyle()
    }
    
}

//MARK: - Object phone number

public extension PhoneNumber {
    
    /// Phone number formatting style
    struct PhoneNumberFormatStyle {
        
        /// Pieces of the phone number
        enum PhoneNumberFormatStyleType: CaseIterable, Codable {
            case parentheses    // Include the parentheses around the area code
            case hyphen         // Include the hyphen in the middle of the phone number
            case space          // Include the space between area code and phone number
            case areaCode       // Area code
            case phoneNumber    // Phone number itself
        }
        
        /// Type of formatting
        var formatStyleTypes: [PhoneNumberFormatStyleType] = []
        
        /// Placeholder character
        var placeholder: Character = "_"
        
        /// Constructor w/placeholder optional
        /// - Parameter placeholder: Placeholder to use instead of '_'
        init(placeholder: Character = "_") {
            self.placeholder = placeholder
        }
        
        /// Constructer to allow extensions to set formatting
        /// - Parameter formatStyleTypes: Format style types
        init(_ formatStyleTypes:  [PhoneNumberFormatStyleType]) {
            self.formatStyleTypes = formatStyleTypes
        }
    }
    
}

extension PhoneNumber.PhoneNumberFormatStyle: ParseableFormatStyle {
    
    /// A `ParseStrategy` that can be used to parse this `FormatStyle`'s output
    public var parseStrategy: PhoneNumberParseStrategy {
        return PhoneNumberParseStrategy()
    }

    public func format(_ value: PhoneNumber) -> String {
        
        // Fill out fields with placeholder
        let stringPlaceholder = String(placeholder)
        let paddedAreaCode = value.areaCode.padding(toLength: 3, withPad: stringPlaceholder, startingAt: 0)
        let paddedExchange = value.exchange.padding(toLength: 3, withPad: stringPlaceholder, startingAt: 0)
        let paddedNumber = value.number.padding(toLength: 4, withPad: stringPlaceholder, startingAt: 0)

        // Get the working style types
        let workingStyleTypes = !formatStyleTypes.isEmpty ? formatStyleTypes : PhoneNumberFormatStyleType.allCases
        
        var output = ""
        if workingStyleTypes.contains(.areaCode) {
            output += workingStyleTypes.contains(.parentheses) ? "(" + paddedAreaCode + ")" : paddedAreaCode
        }
        if workingStyleTypes.contains(.space) && workingStyleTypes.contains(.areaCode) && workingStyleTypes.contains(.phoneNumber) {
            // Without the area code and phone number, no point with space
            output += " "
        }
        if workingStyleTypes.contains(.phoneNumber) {
            output += workingStyleTypes.contains(.hyphen) ? paddedExchange + "-" + paddedNumber : paddedExchange + paddedNumber
        }
        
        // All done
        return output
    }

}

extension PhoneNumber.PhoneNumberFormatStyle: Codable {
    
    enum CodingKeys: String, CodingKey {
        case formatStyleTypes
        case placeholder
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let newTypes = try? container.decodeIfPresent([PhoneNumberFormatStyleType].self, forKey: .formatStyleTypes) {
            formatStyleTypes = newTypes
        }
        if let newPlaceHolder = try? container.decodeIfPresent(String.self, forKey: .placeholder), let characterPlaceholder = newPlaceHolder.first {
            placeholder = characterPlaceholder
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(formatStyleTypes, forKey: .formatStyleTypes)
        try container.encode(String(placeholder), forKey: .placeholder)
    }
    
}

/// Publicly available format styles to allow fluent build of the style
public extension PhoneNumber.PhoneNumberFormatStyle {
    
    /// Return just the area code (e.g. 617)
    /// - Returns: Format style
    func areaCode() -> PhoneNumber.PhoneNumberFormatStyle {
        return getNewFormatStyle(for: .areaCode)
    }
    
    /// Return just the phone number (e.g. 555-1212)
    /// - Returns: Format style
    func phoneNumber() -> PhoneNumber.PhoneNumberFormatStyle {
        return getNewFormatStyle(for: .phoneNumber)
    }
    
    /// Return the space between the area code and phone number
    /// - Returns: Format style
    func space() -> PhoneNumber.PhoneNumberFormatStyle {
        return getNewFormatStyle(for: .space)
    }

    /// Return the parentheses around the area code
    /// - Returns: Format style
    func parentheses() -> PhoneNumber.PhoneNumberFormatStyle {
        return getNewFormatStyle(for: .parentheses)
    }

    /// Return the hyphen in the middle of the phone number
    /// - Returns: Format style
    func hyphen() -> PhoneNumber.PhoneNumberFormatStyle {
        return getNewFormatStyle(for: .hyphen)
    }
    
    /// Get a new phone number format style
    /// - Parameter newType: New type
    /// - Returns: Format style
    private func getNewFormatStyle(for newType: PhoneNumberFormatStyleType) -> PhoneNumber.PhoneNumberFormatStyle {
        if !formatStyleTypes.contains(newType) {
            var newTypes = formatStyleTypes
            newTypes.append(newType)
            return PhoneNumber.PhoneNumberFormatStyle(newTypes)
        }
        // If the user duplicated the type, just return that type
        return self
    }

}
