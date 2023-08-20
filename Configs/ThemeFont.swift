//
//  ThemeFont.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 16/08/23.
//

import UIKit

protocol Font {
  associatedtype Font
  static func regular(size _fontSize: CGFloat) -> Font
  static func bold(size _fontSize: CGFloat) -> Font
  static func demiBold(size _fontSize: CGFloat) -> Font
}

struct ThemeFont: Font {
  //aveniarNext
  typealias Font = UIFont
  static let fontName = "AvenirNext-"
  
  static func regular(size _fontSize: CGFloat) -> UIFont {
    return Font(name: "AvenirNext-Regular", size: _fontSize) ?? .systemFont(ofSize: _fontSize)
  }
  
  static func bold(size _fontSize: CGFloat) -> UIFont {
    return Font(name: "AvenirNext-Bold", size: _fontSize) ?? .systemFont(ofSize: _fontSize)
  }
  
  static func demiBold(size _fontSize: CGFloat) -> UIFont {
    return Font(name: "AvenirNext-DemiBold", size: _fontSize) ?? .systemFont(ofSize: _fontSize)
  }
  
}
