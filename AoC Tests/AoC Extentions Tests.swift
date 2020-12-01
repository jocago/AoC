//
//  AoC Extentions Tests.swift
//  AoC Tests
//
//  Created by Joshua Gohlke on 11/22/20.
//

import XCTest
@testable import AoC
import SwifterSwift

class AoC_Extentions_Tests: XCTestCase {
    
    func test_string_padding_left() {
        XCTAssertEqual("0" + "1", "01")
    }
    
}
