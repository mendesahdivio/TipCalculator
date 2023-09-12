//
//  TipCalculatorSnapshotTest.swift
//  TipCalculatorTests
//
//  Created by ahdivio mendes on 12/09/23.
//

import XCTest
import SnapshotTesting
@testable import TipCalculator

//MARK: please not run these test using the simulator for iphone 14 pro
final class TipCalculatorSnapshotTest: XCTestCase {
  private var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
  }
  
  final func testLogoView() {
    let size = CGSize(width: screenWidth, height: 48)
    let view = LogoView()
    assertSnapshot(matching: view, as: .image(size: size))
  }
 
}

//MARK: result view
extension TipCalculatorSnapshotTest {
  
  final func testInitialResultInputView() {
    let size = CGSize(width: screenWidth, height: 224)
    let view = ResultView()
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  final func testResultViewWithCustomInput() {
    let size = CGSize(width: screenWidth, height: 224)
    let view = ResultView()
    view.configure(result: Result(amountPerPerson: 200, totalBill: 210, totalTip: 5))
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
}


//MARK: Bill inout view
extension TipCalculatorSnapshotTest {
  
  final func testInitialBillInputView() {
    let size = CGSize(width: screenWidth, height: 56)
    let view = BillInputView()
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  final func testBillInputViewWithCustomInout() {
    let size = CGSize(width: screenWidth, height: 56)
    let view = BillInputView()
    let textField = view.allSubViewsOf(type: UITextField.self).first
    textField?.text = "600"
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
}

//MARK: Tip inputView
extension TipCalculatorSnapshotTest {
  
  final func testInitialTipInputView() {
    let size = CGSize(width: screenWidth, height: (56*2) + 16)
    let view = TipInputView()
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  final func testTipInputViewWithCustomInput() {
    let size = CGSize(width: screenWidth, height: (56*2) + 16)
    let view = TipInputView()
    let bttn = view.allSubViewsOf(type: UIButton.self).first
    bttn?.sendActions(for: .touchUpInside)
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
}


//MARK: Split inputView
extension TipCalculatorSnapshotTest {

  final func testInitialSplitInputView() {
    let size = CGSize(width: screenWidth, height: 56)
    let view = SplitInputView()
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  final func testSplitInputViewWithCustomInput() {
    let size = CGSize(width: screenWidth, height: 56)
    let view = SplitInputView()
    let bttn = view.allSubViewsOf(type: UIButton.self).last
    bttn?.sendActions(for: .touchUpInside)
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
}
