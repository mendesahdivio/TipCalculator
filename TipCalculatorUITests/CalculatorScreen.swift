//
//  CalculatorScreen.swift
//  TipCalculatorUITests
//
//  Created by ahdivio mendes on 12/09/23.
//

import XCTest

class CalculatorScreen {
  private let app: XCUIApplication
  
  init(app: XCUIApplication) {
    self.app = app
  }
  
 public var logoView: XCUIElement {
    app.otherElements[ScreenIdentifiers.LogoView.logoView.rawValue]
  }
  
  var totalAmoutPerPersonValueLabel: XCUIElement {
    app.staticTexts[ScreenIdentifiers.ResultView.totalAmountPerPersonValueLabel.rawValue]
  }
  
  
  var totalBillviewValueLable: XCUIElement {
    app.staticTexts[ScreenIdentifiers.ResultView.totalBillValueLabel.rawValue]
  }
  
  var totalTipviewValueLable: XCUIElement {
    app.staticTexts[ScreenIdentifiers.ResultView.totalTipValueLabel.rawValue]
  }
  
  
  // BillInputView
  var billInputViewTextField: XCUIElement {
    app.textFields[ScreenIdentifiers.BillInputView.textField.rawValue]
  }
  
  // TipInpitView
  var tenPercentTipButton: XCUIElement {
    app.buttons[ScreenIdentifiers.TipInputView.tenPercentButton.rawValue]
  }
  
  var fifteenPercentTipButton: XCUIElement {
    app.buttons[ScreenIdentifiers.TipInputView.fifteenPercentButton.rawValue]
  }
  
  var twentyPercentTipButton: XCUIElement {
    app.buttons[ScreenIdentifiers.TipInputView.twentyPercentButton.rawValue]
  }
  
  var customTipButton: XCUIElement {
    app.buttons[ScreenIdentifiers.TipInputView.customTipButton.rawValue]
  }
  
  var customTipAlertTextField: XCUIElement {
    app.textFields[ScreenIdentifiers.TipInputView.customTipAlertTextField.rawValue]
  }
  
  // SplitInputView
  var incrementButton: XCUIElement {
    app.buttons[ScreenIdentifiers.SplitInputView.incrementButton.rawValue]
  }
  
  var decrementButton: XCUIElement {
    app.buttons[ScreenIdentifiers.SplitInputView.decrementButton.rawValue]
  }
  
  var splitValueLabel: XCUIElement {
    app.staticTexts[ScreenIdentifiers.SplitInputView.quantityValueLabel.rawValue]
  }
  
  // Actions
  
  func enterBill(amount: Double) {
    billInputViewTextField.tap()
    billInputViewTextField.typeText("\(amount)\n")
  }
  
  func selectTip(tip: Tip) {
    switch tip {
    case .tenPercent:
      tenPercentTipButton.tap()
    case .fiftyPercent:
      fifteenPercentTipButton.tap()
    case .twentyPercent:
      twentyPercentTipButton.tap()
    case .custom(let value):
      customTipButton.tap()
      XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1.0))
      customTipAlertTextField.typeText("\(value)\n")
    case .none:
      print("failed")
    }
  }
  
  func selectIncrementButton(numberOfTaps: Int) {
    incrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
  }
  
  func selectDecrementButton(numberOfTaps: Int) {
    decrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
  }
  
  func doubleTapLogoView() {
    logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
  }

  
}
