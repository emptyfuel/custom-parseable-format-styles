//
//  PhoneNumberFormatStyleTests.swift
//  PhoneNumberFormatStyleTests
//
//  Created by Mark Thormann on 8/13/21.
//

import XCTest
@testable import PhoneNumberTextField

class PhoneNumberFormatStyleTests: XCTestCase {

    func testPhoneNumberFormatStyleWithValidNumberAndDefaultSettingsSucceeds() {
        // Given
        let number = "1234567890"
        let expected = [
            "(1__) ___-____",
            "(12_) ___-____",
            "(123) ___-____",
            "(123) 4__-____",
            "(123) 45_-____",
            "(123) 456-____",
            "(123) 456-7___",
            "(123) 456-78__",
            "(123) 456-789_",
            "(123) 456-7890"
        ]
        
        // When
        for i in 0..<number.count {
            guard let input = try? PhoneNumberParseStrategy().parse(String(number.prefix(i + 1))) else {
                XCTFail("Could not parse phone number")
                return
            }
            
            let actual = input.formatted(.phoneNumber)

            // Then
            XCTAssertEqual(expected[i], actual)
        }
    }
    
    func testPhoneNumberFormatStyleWithValidNumberAndNoPunctuationSucceeds() {
        // Given
        let number = "1234567890"
        let expected = [
            "1_________",
            "12________",
            "123_______",
            "1234______",
            "12345_____",
            "123456____",
            "1234567___",
            "12345678__",
            "123456789_",
            "1234567890"
        ]
        
        // When
        for i in 0..<number.count {
            guard let input = try? PhoneNumberParseStrategy().parse(String(number.prefix(i + 1))) else {
                XCTFail("Could not parse phone number")
                return
            }
            let actual = input.formatted(.phoneNumber.areaCode().number())

            // Then
            XCTAssertEqual(expected[i], actual)
        }
    
    }
    
    func testPhoneNumberFormatStyleWithValidNumberAndSpaceHyphenSucceeds() {
        // Given
        let number = "1234567890"
        let expected = [
            "1__ ___-____",
            "12_ ___-____",
            "123 ___-____",
            "123 4__-____",
            "123 45_-____",
            "123 456-____",
            "123 456-7___",
            "123 456-78__",
            "123 456-789_",
            "123 456-7890"
        ]
        
        // When
        for i in 0..<number.count {
            guard let input = try? PhoneNumberParseStrategy().parse(String(number.prefix(i + 1))) else {
                XCTFail("Could not parse phone number")
                return
            }
            
            let actual = input.formatted(.phoneNumber.areaCode().number().space().hyphen())

            // Then
            XCTAssertEqual(expected[i], actual)
        }
    
    }
    
    func testPhoneNumberFormatStyleWithJustPhoneNumberAndHyphenSucceeds() {
        // Given
        let number = "1234567890"
        let expected = [
            "___-____",
            "___-____",
            "___-____",
            "4__-____",
            "45_-____",
            "456-____",
            "456-7___",
            "456-78__",
            "456-789_",
            "456-7890"
        ]
        
        // When
        for i in 0..<number.count {
            guard let input = try? PhoneNumberParseStrategy().parse(String(number.prefix(i + 1))) else {
                XCTFail("Could not parse phone number")
                return
            }
            
            let actual = input.formatted(.phoneNumber.number().space().hyphen())

            // Then
            XCTAssertEqual(expected[i], actual)
        }
    
    }
    
    func testPhoneNumberFormatStyleWithInvalidInputSucceeds() {
        // Given
        let number = "DASSEW@#*@$*($@"
        let expected = "(___) ___-____"
        
        // When
        guard let input = try? PhoneNumberParseStrategy().parse(number) else {
            XCTFail("Could not parse phone number")
            return
        }
        let actual = input.formatted(.phoneNumber)

        // Then
        XCTAssertEqual(expected, actual)
    }
    
    func testPhoneNumberFormatStyleWithInvalidInputAndSomeNumbersSucceeds() {
        // Given
        let number = "123DASS45EW@#*@$*($@"
        let expected = "(123) 45_-____"
        
        // When
        guard let input = try? PhoneNumberParseStrategy().parse(number) else {
            XCTFail("Could not parse phone number")
            return
        }
        let actual = input.formatted(.phoneNumber)


        // Then
        XCTAssertEqual(expected, actual)
    }

}
