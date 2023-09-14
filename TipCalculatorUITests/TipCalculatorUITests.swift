//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by ahdivio mendes on 15/08/23.
//

import XCTest

final class TipCalculatorUITests: XCTestCase {
  private var app: XCUIApplication!
  
  
  private var screen: CalculatorScreen {
    return CalculatorScreen(app: app)
  }

  override func setUp() {
    super.setUp()
    app = .init()
    app.launch()
  }
  
  override func tearDown() {
    super.tearDown()
    app = nil
  }
}

//Result view test
extension TipCalculatorUITests {
  final func testResultViewDefaultValues() {
    XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "\u{20B9} 0")
    XCTAssertEqual(screen.totalBillviewValueLable.label, "\u{20B9} 0")
    XCTAssertEqual(screen.totalTipviewValueLable.label, "\u{20B9} 0")
  }
}

//TipView
extension TipCalculatorUITests {
  final func testRegularTip() {
    // User enters a $100 bill
    screen.enterBill(amount: 100)
    XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "\u{20B9} 100")
    XCTAssertEqual(screen.totalBillviewValueLable.label, "\u{20B9} 100")
    XCTAssertEqual(screen.totalTipviewValueLable.label, "\u{20B9} 0")
  }
}
