//
//  Tip.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 28/08/23.
//

import Foundation

enum Tip {
  case none
  case tenPercent
  case fiftyPercent
  case twentyPercent
  case custom(value: Int)
  
  var stringValue:String {
    switch self {
    case .none:
      return ""
    case .tenPercent:
      return "10%"
    case .fiftyPercent:
      return "50%"
    case .twentyPercent:
      return "20%"
    case .custom(let value):
      return String(value)
    }
  }
}
