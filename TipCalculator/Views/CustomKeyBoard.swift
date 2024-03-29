//
//  CustomKeyBoard.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 19/08/23.
//
import UIKit

protocol CustomKeyBoardProtocol {
  var toolBar: UIToolbar  {get}
  func additems(items: [UIBarButtonItem])
  func setBarstyle(barStyle: UIBarStyle)
  func setSizeToFit()
  func setEnableUserInteraction()
  func setEnableMultiTouch()
}


class CustomKeyBoard: UIToolbar, CustomKeyBoardProtocol {
 
  internal var toolBar: UIToolbar {return self}
  
  
  init(frame: CGRect, sizeToFit: Bool = false, enableUserInteraction: Bool = false, enableMultiTouch: Bool = false) {
    super.init(frame: frame)
    sizeToFit ? setSizeToFit() : print("setSizeToFit == false")
    enableUserInteraction ? setEnableUserInteraction() :  print("EnableUserInteractionnot == false")
    enableMultiTouch ? setEnableMultiTouch() : print("setEnableMultiTouch == false")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  final func additems(items: [UIBarButtonItem]) {
    toolBar.items = items
  }
  
  final func setBarstyle(barStyle: UIBarStyle) {
    toolBar.barStyle = barStyle
  }
  
  final func setSizeToFit() {
    toolBar.sizeToFit()
  }
  
  final func setEnableUserInteraction() {
    toolBar.isUserInteractionEnabled = true
  }
  
 final func setEnableMultiTouch() {
    toolBar.isMultipleTouchEnabled = true
  }
  
}
