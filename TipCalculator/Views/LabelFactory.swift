//
//  LabelFactory.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 16/08/23.
//


import UIKit

protocol LabelFactory {
  associatedtype Font
  associatedtype Label
  static func buildLabel(text: String?, font: Font, backgroundColour: UIColor, textColour: UIColor, textAlignment: NSTextAlignment) -> Label
}

struct LabelView: LabelFactory {
  typealias Font = UIFont
  typealias Label = UILabel
  
  static func buildLabel(text: String?,
                         font: UIFont,
                         backgroundColour: UIColor = .clear,
                         textColour: UIColor = ThemeColour.textColour,
                         textAlignment: NSTextAlignment = .center) -> UILabel {
    let label = Label()
    label.text = text ?? ""
    label.font = font
    label.textColor = textColour
    label.textAlignment = textAlignment
    return label
  }
  
}
