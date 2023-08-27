//
//  TextFieldView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 19/08/23.
//

import UIKit


protocol TextFieldProtocol {
  var textField: UITextField {get}
  func setAccessorView(view: UIView)
}


class CustomTextFieldView: UITextField, TextFieldProtocol {
  var textField: UITextField {return self}
  
  init(borderStyle: UITextField.BorderStyle = .none, keyBoardType: UIKeyboardType = .default, tintColour: UIColor = .white, textColour: UIColor = .black, font: UIFont) {
    super.init(frame: .zero)
    textField.borderStyle = borderStyle
    textField.keyboardType = keyBoardType
    textField.tintColor = tintColour
    textField.textColor = textColour
    textField.font = font
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  final func setAccessorView(view: UIView) {
    textField.inputAccessoryView = view
  }

}
