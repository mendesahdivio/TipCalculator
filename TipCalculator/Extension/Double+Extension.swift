//
//  Double+Extension.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 10/09/23.
//

import Foundation
extension Double {
  var stringValue: String {
    return String(self)
  }
  
  var currencyString: String {
    var isWholeNumber: Bool {
      isZero ? true: !isNormal ? false: self == rounded()
    }
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
    return formatter.string(for: self) ?? ""
  }
}
