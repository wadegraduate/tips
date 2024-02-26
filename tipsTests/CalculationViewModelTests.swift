//
//  CalculationViewModelTests.swift
//  tipsTests
//
//  Created by Wadealanchan on 25/2/2024.
//

import XCTest
@testable import Tips

final class CalculationViewModelTests: XCTestCase {

 private var sut : CalculationViewModel!
    
    override func setUp() {
        super.setUp()
        sut = CalculationViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTotalAmountWithTip_shouldReturnTrue() {
        sut.billAmount = 10.0
        sut.tipPercentage = 8.0
        
        let totalWithTip = sut.totalAmountWithTip
        XCTAssertEqual(totalWithTip, 10.8)
    }
    
    func test_resetValues_shouldClearAllValues() {
        sut.billAmount = 13
        sut.tipPercentage = 15
        
        sut.resetValues()
        XCTAssertNil(sut.billAmount)
        XCTAssertEqual(sut.tipPercentage, 0.0)
    }
    
    func test_resetValues_shouldReturnTrue() {
        sut.resetValues()
        
        XCTAssertTrue(sut.billAmount == nil)
        XCTAssertTrue(sut.tipPercentage == 0)
    }

}
